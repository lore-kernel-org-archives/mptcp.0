Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9270
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 22:36:55 +0000 (UTC)
IronPort-SDR: Gc+H5L//N1A0Fl1PmuxZn7y7Lxi5wRdv1S99n4RbKbZkrv4i4C9oMOHQxLLTFA3VW19yskvN5s
 4KCk5q+DZEOg==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="207607950"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="207607950"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 15:36:54 -0700
IronPort-SDR: ZsEzbSB2Ebkl8uhugqhFfXk7ur7YwpO/jPh8T3tFKhXklm33DsT0tcT6lw2BxsGVfsgi8+7Nul
 shJlpUdP0HAA==
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="487942735"
Received: from vedsingh-mobl1.amr.corp.intel.com ([10.212.254.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 15:36:53 -0700
Date: Thu, 24 Jun 2021 15:36:53 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jianguo Wu <wujianguo106@163.com>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
Subject: Re: [PATCH v5 3/4] mptcp: fix syncookie process if mptcp can not_accept
 new subflow
In-Reply-To: <20b9b6cc-0527-90ae-0fa7-61842d50ad39@163.com>
Message-ID: <993edc23-401e-6c2f-63c9-983826c551f1@linux.intel.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com> <1623840570-42004-4-git-send-email-wujianguo106@163.com> <3cdb43ff-a2c2-6599-4e8-3cb569e1a26a@linux.intel.com> <cebfba8a-7576-3b9a-2017-66ab276d1f06@163.com>
 <20b9b6cc-0527-90ae-0fa7-61842d50ad39@163.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-361432297-1624574213=:99274"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-361432297-1624574213=:99274
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 24 Jun 2021, Jianguo Wu wrote:

>
>
> On 2021/6/21 14:24, Jianguo Wu wrote:
>>
>> Hi Mat,
>>
>> On 2021/6/19 7:19, Mat Martineau wrote:
>>> On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
>>>
>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>
>>>> Lots of "TCP: tcp_fin: Impossible, sk->sk_state=7" in client side
>>>> when doing stress testing.
>>>
>>> Hi Jianguo -
>>>
>>> Like patch 1, do the existing syncookie selftests trigger this sometimes?
>>>
>>> Or are there selftests that could be added to this series, or packetdrill tests, to do such syncookie stress tests?
>>>
>>
>> This is triggered by the same test in patch 1,
>> I will try selftests too, or add selftest if necessary.
>>
>>> Thanks,
>>>
>>> Mat
>>>
>>>
>>>>
>>>> There are at least two cases may trigger this warning:
>>>> 1.mptcp is in syncookie, and server recv MP_JOIN SYN request,
>>>>  in subflow_check_req(), the mptcp_can_accept_new_subflow()
>>>>  return false, so subflow_init_req_cookie_join_save() isn't
>>>>  called, i.e. not store the data present in the MP_JOIN syn
>>>>  request and the random nonce in hash table - join_entries[],
>>>>  but still send synack. When recv 3rd-ack,
>>>>  mptcp_token_join_cookie_init_state() will return false, and
>>>>  3rd-ack is dropped, then if mptcp conn is closed by client,
>>>>  client will send a DATA_FIN and a MPTCP FIN, the DATA_FIN
>>>>  doesn't have MP_CAPABLE or MP_JOIN,
>>>>  so mptcp_subflow_init_cookie_req() will return 0, and pass
>>>>  the cookie check, MP_JOIN request is fallback to normal TCP.
>>>>  Server will send a TCP FIN if closed, in client side,
>>>>  when process TCP FIN, it will do reset, the code path is:
>>>>    tcp_data_queue()->mptcp_incoming_options()
>>>>      ->check_fully_established()->mptcp_subflow_reset().
>>>>  mptcp_subflow_reset() will set sock state to TCP_CLOSE,
>>>>  so tcp_fin will hit TCP_CLOSE, and print the warning.
>>>> 2.mptcp is in syncookie, and server recv 3rd-ack, in
>>>>  mptcp_subflow_init_cookie_req(), mptcp_can_accept_new_subflow()
>>>>  return false, and subflow_req->mp_join is not set to 1,
>>>>  so in subflow_syn_recv_sock() will not reset the MP_JOIN
>>>>  subflow, but fallback to normal TCP, and then the same thing
>>>>  happens when server will send a TCP FIN if closed.
>>>>
>>>> For case1, subflow_check_req() return -EPERM,
>>>> then tcp_conn_request() will drop MP_JOIN SYN.
>>>>
>
> Hi Mat,
>
> As MP_JOIN SYN is dropped, no SYN/ACK will be replied, So test case "subflows limited by server w cookies" in mptcp_join.sh should be updated,
> like this:
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 523c7797f30a..37b7da3cd5ca 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1398,7 +1398,7 @@ syncookies_tests()
>        ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
>        ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
>        run_tests $ns1 $ns2 10.0.1.1
> -       chk_join_nr "subflows limited by server w cookies" 2 2 1
> +       chk_join_nr "subflows limited by server w cookies" 2 1 1
>
>        # test signal address with cookies
>        reset_with_cookies
>
> Is this OK?
>

Hi Jianguo -

Yes, you should include a selftest patch in the series to make the change, 
since the expected behavior is changing.

-Mat


>
>>>> For case2, let subflow_syn_recv_sock() call mptcp_can_accept_new_subflow(),
>>>> and do fatal fallback, send reset.
>>>>
>>>> Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use")
>>>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>> ---
>>>> net/mptcp/subflow.c | 6 +++---
>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>>> index 75ed530706c0..6d98e19a20aa 100644
>>>> --- a/net/mptcp/subflow.c
>>>> +++ b/net/mptcp/subflow.c
>>>> @@ -224,6 +224,8 @@ static int subflow_check_req(struct request_sock *req,
>>>>         if (unlikely(req->syncookie)) {
>>>>             if (mptcp_can_accept_new_subflow(subflow_req->msk))
>>>>                 subflow_init_req_cookie_join_save(subflow_req, skb);
>>>> +            else
>>>> +                return -EPERM;
>>>>         }
>>>>
>>>>         pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
>>>> @@ -263,9 +265,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>>>>         if (!mptcp_token_join_cookie_init_state(subflow_req, skb))
>>>>             return -EINVAL;
>>>>
>>>> -        if (mptcp_can_accept_new_subflow(subflow_req->msk))
>>>> -            subflow_req->mp_join = 1;
>>>> -
>>>> +        subflow_req->mp_join = 1;
>>>>         subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq - 1;
>>>>     }
>>>>
>>>> --

--
Mat Martineau
Intel
--0-361432297-1624574213=:99274--
