Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71242C9C
	for <mptcp@lists.linux.dev>; Sat, 18 Dec 2021 02:05:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219887016"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="219887016"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 18:05:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="520821624"
Received: from jasanch5-mobl1.amr.corp.intel.com ([10.212.247.3])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 18:05:13 -0800
Date: Fri, 17 Dec 2021 18:05:13 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: add mp_fail testcases
In-Reply-To: <20211206043305.GA8840@dhcp-10-157-36-190>
Message-ID: <9fc1b3f9-1020-4167-4b4e-4a824f67d9c@linux.intel.com>
References: <4dd1a9febb11730329ef3486c6dcb1eac3b68d9c.1638443671.git.geliang.tang@suse.com> <eb9275dc-b9bd-2299-c4aa-1b537a82b57@linux.intel.com> <20211206043305.GA8840@dhcp-10-157-36-190>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Dec 2021, Geliang Tang wrote:

> Hi Mat,
>
> On Thu, Dec 02, 2021 at 05:20:16PM -0800, Mat Martineau wrote:
>> On Thu, 2 Dec 2021, Geliang Tang wrote:
>>
>>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
>>> checksum failure.
>>>
>>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
>>> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>> v3:
>>>  - "file received by server does not match" still there.
>>
>> Other than the "does not match" errors in the files, the tests are passing
>> for me and the wireshark captures show a single MP_FAIL in each test.
>>
>> I would expect the file mismatch on the single subflow test, since it falls
>> back to TCP and the packets are still altered after fallback. For this test,
>> the script could just confirm the file lengths match. Or, better yet, have a
>> custom check that confirms that the bytes in each file either match or are
>> inverses.
>
> I'll add this check as a squash-to patch.
>
>>
>> But with the multiple subflow test, I would expect the checksum mismatch on
>> one subflow to reset that subflow and throw away the data with the bad
>> checksum. Then the remaining subflow would have unaltered data, so the files
>> should match. (And if the remaining subflow had a checksum error, the data
>> would be discarded and that subflow would be reset). Seems like the file
>> mismatch here is indicating that corrupted data is not being discarded as it
>> should be - do you agree?
>
> Yes, the corrupted data is not being discarded. I've tried to solve this
> problem for weeks, but I haven't solved it yet.
>
> We use "sk_eat_skb" to discard all the data on the receive queue like
> this:
>
> 1170                 if (subflow->send_mp_fail) {
> 1171                         if (mptcp_has_another_subflow(ssk) ||
> 1172                             !READ_ONCE(msk->allow_infinite_fallback)) {
> 1173                                 ssk->sk_err = EBADMSG;
> 1174                                 tcp_set_state(ssk, TCP_CLOSE);
> 1175                                 subflow->reset_transient = 0;
> 1176                                 subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> 1177                                 tcp_send_active_reset(ssk, GFP_ATOMIC);
> 1178                                 while ((skb = skb_peek(&ssk->sk_receive_queue)))
> 1179                                         sk_eat_skb(ssk, skb);
> 1180                         }
> 1181                         WRITE_ONCE(subflow->data_avail, 0);
> 1182                         return true;
> 1183                 }
>
> But it doesn't work. The corrupted data is still on msk->receive_queue, so
> the corrupted data will still be received in __mptcp_recvmsg_mskq().
>
> I tried to add this code to purge the receiving queue and the out_of_order
> queue of msk too:
>
>        __skb_queue_purge(&sk->sk_receive_queue);
>        skb_rbtree_purge(&msk->out_of_order_queue);
>
> Still doesn't work.
>
> Please give me some help about this.

Hi Geliang -

Unfortunately this message ended up deep in my inbox.

With get_mapping_status() returning MAPPING_EMPTY while there is not 
enough data in the ssk->sk_receive_queue to calculate the checksum, the 
data should not get moved to the msk queue until after the checksum is 
calculated (if it is, that's a bug).

Maybe you could add some debug code to check subflow->send_mp_fail in 
__mptcp_move_skbs_from_subflow() and move_skbs_to_msk() (and maybe further 
up the stack) to see how and when the data is getting copied after a 
checksum failure.


--
Mat Martineau
Intel
