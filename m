Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E8223DFB
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452468; cv=none; b=ADVuP5ZjG6On+u1xQePlSkKRS9qnrxohDe/VgI8Q/++rTsQ8hSUgpe1L7hdjUnZLaYJoLykrMmPSzOXoa33u67PSAhl7oIPwvn+EZQgSUSctrNlSd1alZDnmitiBz37bKrYtnwuzk1zMfnDy/uF1xTwUnsTfDMPave1b2BwYK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452468; c=relaxed/simple;
	bh=n3kJvNT8kmf7dhkZLIprOXe3zr+5i1fOjG6Ntxio0Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0lU3dx2x91ZkJHkTzDBruzwM+MQb/P661aVMDxpR5gPSYhdv3NufCgAwyYqIjb7kynJvhkZIDndn8qH1/XTdoFsxlno6KYSyW0j+NovNPCfzYvsR+Tm79+qhHoxYwE56zeCVMCHwjJLV1CcJ00z+HxoMgIxhnfnCPNwnJ8mqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA+Vx8ZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA+Vx8ZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18166C116C6;
	Mon, 26 Jan 2026 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769452467;
	bh=n3kJvNT8kmf7dhkZLIprOXe3zr+5i1fOjG6Ntxio0Tg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WA+Vx8ZWPBGvFMKGOErRBOTMWBX+RUYNsRPHhHts+CYlshhM0quufu6E7pTf+lBPZ
	 yh49dl5uPGjIh/chodIGOqO5Xj0As0btHuqFAfqEsw3F30/R2HfQpPZdfhyNfHozYS
	 UAHdvQ4ckLsrzxzixLsmKpkjZDasX95a2rNgkfTQ9iIC/P/Pa+dvJ1Dw2gKCbrqwS/
	 D5RiTBM7FVuE8zD5SNxT2Doccj+2Rsa+qtA2ynLnG4gPQBeEK2vdW1Iojh85yNzJP5
	 YfIq7WUfb2TeVaLMQcJDjLo1KlhZ4unTm3h/qtDatGnPiqGcl/QzxiFyNVJLKOvjqJ
	 hr1+rOHv2Rumg==
Message-ID: <c27f82ac-dcf6-4ea2-8163-cd2615f9a096@kernel.org>
Date: Mon, 26 Jan 2026 19:34:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: always set as unavail
 when removing addr
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com
References: <20251215-issue-606-mark-subflow-endp-avail-v1-0-2f1b36da8993@kernel.org>
 <20251215-issue-606-mark-subflow-endp-avail-v1-1-2f1b36da8993@kernel.org>
 <2059f374-0447-30ff-92ff-b090fd91504d@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2059f374-0447-30ff-92ff-b090fd91504d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for the review!

On 15/01/2026 05:56, Mat Martineau wrote:
> On Mon, 15 Dec 2025, Matthieu Baerts (NGI0) wrote:
> 
>> Syzkaller managed to find a combination of actions that was generating
>> this warning:

(...)

>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index f59d21e7579c..51bcfcec882d 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -1057,10 +1057,8 @@ static bool mptcp_pm_remove_anno_addr(struct
>> mptcp_sock *msk,
>>     ret = mptcp_remove_anno_list_by_saddr(msk, addr);
>>     if (ret || force) {
>>         spin_lock_bh(&msk->pm.lock);
>> -        if (ret) {
>> -            __set_bit(addr->id, msk->pm.id_avail_bitmap);
>> +        if (ret)
>>             msk->pm.add_addr_signaled--;
>> -        }
>>         mptcp_pm_remove_addr(msk, &list);
>>         spin_unlock_bh(&msk->pm.lock);
>>     }
>> @@ -1098,17 +1096,14 @@ static int
>> mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
>>                       !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
>>
>>         list.ids[0] = mptcp_endp_get_local_id(msk, addr);
>> -        if (remove_subflow) {
>> -            spin_lock_bh(&msk->pm.lock);
>> -            mptcp_pm_rm_subflow(msk, &list);
>> -            spin_unlock_bh(&msk->pm.lock);
>> -        }
>>
>> -        if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
>> -            spin_lock_bh(&msk->pm.lock);
>> +        spin_lock_bh(&msk->pm.lock);
>> +        if (remove_subflow)
>> +            mptcp_pm_rm_subflow(msk, &list);
>> +        if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
>>             __mark_subflow_endp_available(msk, list.ids[0]);
>> -            spin_unlock_bh(&msk->pm.lock);
>> -        }
>> +        __set_bit(addr->id, msk->pm.id_avail_bitmap);
> 
> There's not any harm in setting this bit a second time if it was also
> set in __mark_subflow_endp_available().
> 
> However, __mark_subflow_endp_available() has some logic around ID 0 and
> mpc_endpoint_id. Is that relevant in this code path or is the new
> __set_bit() doing the correct thing by always clearing based on addr->id?

Good point. Even if there is no harm, no need to set the bit for ID 0. I
will look at that!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

