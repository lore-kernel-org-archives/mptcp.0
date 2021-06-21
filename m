Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BC072
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 06:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=txOim
	mKA9GXckhvFt1tsEGoSYkE45hPS2WGgtrzbRH0=; b=PR46oVIHoA6C0V9HpEZJ+
	osFZ1FjXQ0aqWMKZ1WRLUe03KKcSLuSYylpPkmT+IeGObAnhF75U1fOtzFE7dPGH
	puE8GCcCQLuzt8T4jYsWwqRmd5pnpZd75RVHhWhtO4rFZdntVRolFPcYiZwuXWpr
	lkQtkAj+ftdDLH35bXxUL8=
Received: from [10.8.1.202] (unknown [36.111.140.26])
	by smtp7 (Coremail) with SMTP id C8CowAAHHZ2CMNBg4QyNjA--.489S2;
	Mon, 21 Jun 2021 14:24:04 +0800 (CST)
Subject: Re: [PATCH v5 3/4] mptcp: fix syncookie process if mptcp can
 not_accept new subflow
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
 <1623840570-42004-4-git-send-email-wujianguo106@163.com>
 <3cdb43ff-a2c2-6599-4e8-3cb569e1a26a@linux.intel.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <cebfba8a-7576-3b9a-2017-66ab276d1f06@163.com>
Date: Mon, 21 Jun 2021 14:24:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3cdb43ff-a2c2-6599-4e8-3cb569e1a26a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:C8CowAAHHZ2CMNBg4QyNjA--.489S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1DZr4rtrW7Ar4ftFWrKrg_yoW5Kry8pr
	W8Xa17trn5XFy3CF4SyF4UXr1j9FWYyrZxtw45K347Aw1qv3s3Kry8KFW09ryxCFs3GFyF
	yr4jq3ZFy3ZFyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jHXdUUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9wW4kF2MZU5xUwAAsC


Hi Mat,

On 2021/6/19 7:19, Mat Martineau wrote:
> On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
> 
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> Lots of "TCP: tcp_fin: Impossible, sk->sk_state=7" in client side
>> when doing stress testing.
> 
> Hi Jianguo -
> 
> Like patch 1, do the existing syncookie selftests trigger this sometimes?
> 
> Or are there selftests that could be added to this series, or packetdrill tests, to do such syncookie stress tests?
> 

This is triggered by the same test in patch 1,
I will try selftests too, or add selftest if necessary.

> Thanks,
> 
> Mat
> 
> 
>>
>> There are at least two cases may trigger this warning:
>> 1.mptcp is in syncookie, and server recv MP_JOIN SYN request,
>>  in subflow_check_req(), the mptcp_can_accept_new_subflow()
>>  return false, so subflow_init_req_cookie_join_save() isn't
>>  called, i.e. not store the data present in the MP_JOIN syn
>>  request and the random nonce in hash table - join_entries[],
>>  but still send synack. When recv 3rd-ack,
>>  mptcp_token_join_cookie_init_state() will return false, and
>>  3rd-ack is dropped, then if mptcp conn is closed by client,
>>  client will send a DATA_FIN and a MPTCP FIN, the DATA_FIN
>>  doesn't have MP_CAPABLE or MP_JOIN,
>>  so mptcp_subflow_init_cookie_req() will return 0, and pass
>>  the cookie check, MP_JOIN request is fallback to normal TCP.
>>  Server will send a TCP FIN if closed, in client side,
>>  when process TCP FIN, it will do reset, the code path is:
>>    tcp_data_queue()->mptcp_incoming_options()
>>      ->check_fully_established()->mptcp_subflow_reset().
>>  mptcp_subflow_reset() will set sock state to TCP_CLOSE,
>>  so tcp_fin will hit TCP_CLOSE, and print the warning.
>> 2.mptcp is in syncookie, and server recv 3rd-ack, in
>>  mptcp_subflow_init_cookie_req(), mptcp_can_accept_new_subflow()
>>  return false, and subflow_req->mp_join is not set to 1,
>>  so in subflow_syn_recv_sock() will not reset the MP_JOIN
>>  subflow, but fallback to normal TCP, and then the same thing
>>  happens when server will send a TCP FIN if closed.
>>
>> For case1, subflow_check_req() return -EPERM,
>> then tcp_conn_request() will drop MP_JOIN SYN.
>>
>> For case2, let subflow_syn_recv_sock() call mptcp_can_accept_new_subflow(),
>> and do fatal fallback, send reset.
>>
>> Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use")
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>> ---
>> net/mptcp/subflow.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 75ed530706c0..6d98e19a20aa 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -224,6 +224,8 @@ static int subflow_check_req(struct request_sock *req,
>>         if (unlikely(req->syncookie)) {
>>             if (mptcp_can_accept_new_subflow(subflow_req->msk))
>>                 subflow_init_req_cookie_join_save(subflow_req, skb);
>> +            else
>> +                return -EPERM;
>>         }
>>
>>         pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
>> @@ -263,9 +265,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>>         if (!mptcp_token_join_cookie_init_state(subflow_req, skb))
>>             return -EINVAL;
>>
>> -        if (mptcp_can_accept_new_subflow(subflow_req->msk))
>> -            subflow_req->mp_join = 1;
>> -
>> +        subflow_req->mp_join = 1;
>>         subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq - 1;
>>     }
>>
>> -- 
>> 1.8.3.1
>>
>>
>>
> 
> -- 
> Mat Martineau
> Intel

