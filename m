Received: from chinatelecom.cn (smtpnm6-03.21cn.com [182.42.153.190])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D3017BA7
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.153.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792902; cv=none; b=W2kxXpV0vf9zdskLN9l041LbTUqK/1lvqJkTl2+p9jc8JK/VixzJAcwS85+q3eTgr0KEOymtzp1ll8X4HytgXnFIbbvlfiAAAiW9GK6cIl37eZWEcFil2VJFexNLmzhgjrw9bOB7yO4rpeeaqjM9dr8T2leeVfSL7LxVTVvrqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792902; c=relaxed/simple;
	bh=NDlA9hEI/uEhsHHiTtsh8E8CSu7Oun4o8BwHvD6zVJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0MIla5/o1raFs9AKKoCgkteO4XBkYy3fUnqrq2BDQDUtBRnNr7Im8AGwhvH73aJSZ4F+UYmC5bUt7YMwM+aAknjNtzNRnp25yK3RN56dP30T9hrpAAgTxyDWeAqFR1s1yLDq8D49oU2pgftfD0VHGCe+lSKYX5eo5YG5XB2LZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.153.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.138.117:9908.1841006941
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.68 (unknown [192.168.138.117])
	by chinatelecom.cn (HERMES) with SMTP id 4EAE49B0A4;
	Mon, 27 May 2024 14:44:21 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([27.148.194.68])
	by gateway-ssl-dep-67bdc54df-qz2qs with ESMTP id affe0e088499455b963c531a4e93fd6c for matttbe@kernel.org;
	Mon, 27 May 2024 14:44:25 CST
X-Transaction-ID: affe0e088499455b963c531a4e93fd6c
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 27.148.194.68
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Message-ID: <04c0fd97-1144-4480-9ea0-7e54645431c9@chinatelecom.cn>
Date: Mon, 27 May 2024 14:44:17 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: make RMADDR MIB counter clearly
To: Matthieu Baerts <matttbe@kernel.org>
Cc: geliang@kernel.org, mptcp@lists.linux.dev
References: <1716450994-5145-1-git-send-email-liyonglong@chinatelecom.cn>
 <208134576.5417.1716773783465.JavaMail.root@jt-retransmission-dep-59f6f76b7b-m2drk>
Content-Language: en-US
From: YonglongLi <liyonglong@chinatelecom.cn>
In-Reply-To: <208134576.5417.1716773783465.JavaMail.root@jt-retransmission-dep-59f6f76b7b-m2drk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Matt,

Thanks for your replay.

On 5/24/2024 22:50, Matthieu Baerts wrote:
> Hi Yonglong,
> 
> Thank you for sharing this patch!
> 
> On 23/05/2024 09:56, Yonglong Li wrote:
>> From: YonglongLi <liyonglong@chinatelecom.cn>
>>
>> it should inc RMADDR MIB counter when received RMADDR but didn't
>> find any subflow related,
> 
> I suggest using this text instead:
> 
>  The RmAddr MIB counter is supposed to be incremented once when a valid
>  RM_ADDR has been received. Before this patch, it could have been
>  incremented as many times as the number of subflows connected to the
>  the linked address ID, so it could have been 0, 1 or more than 1.
> 
>  The "RmSubflow" is incremented after a local operation. In this case,
>  it is normal to tied it with the number of subflows that have been
>  actually removed.
> 
> WDYT?

Thanks.

> 
>>
>> Fixes: 7a7e52e38a40 ("mptcp: add RM_ADDR related mibs")
>>
> 
> There should be no empty lines here between the Fixes and the SoB tags.
> 
> (I can modify the commit message when applying the patch, no need to
> send a v2)
> 
>> Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
>> ---
>>  net/mptcp/pm_netlink.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 7f53e02..766a840 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -814,10 +814,13 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
>>  			spin_lock_bh(&msk->pm.lock);
>>  
>>  			removed = true;
>> -			__MPTCP_INC_STATS(sock_net(sk), rm_type);
>> +			if (rm_type == MPTCP_MIB_RMSUBFLOW)
>> +				__MPTCP_INC_STATS(sock_net(sk), rm_type);
>>  		}
>>  		if (rm_type == MPTCP_MIB_RMSUBFLOW)
>>  			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
>> +		else if (rm_type == MPTCP_MIB_RMADDR)
>> +			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> 
> The modification looks good to me.
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> It would be good to modify the selftests to avoid any regressions later,
> and to cover this case. But I'm not sure how to reproduce your case
> where a RM_ADDR is received but for an ID that is not being used by the
> PM. Do you know more about your case? Maybe because the subflows have
> just been removed?
> 

I reporduce it just add a bcast ip addr which will cause join connect failed.
Like this:

if reset "remove addresses with join failed"; then
        pm_nl_set_limits $ns1 3 3
        pm_nl_add_endpoint $ns1 224.0.0.1  flags signal
        pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
        pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
        pm_nl_set_limits $ns2 4 4
        run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
        chk_join_nr 2 2 2
        chk_add_nr 3 3
        chk_rm_nr 3 2 invert
        chk_rst_nr 0 0
fi


> The issue to reproduce that in the selftests is that we cannot (easily)
> send a RM_ADDR for an ID that is not currently handled by the PM (if I'm
> not mistaken). Probably better to do that with Packetdrill [1].
> 
> What we can do instead, is to have subflows reusing the same ID multiple
> times, e.g. using the fullmesh PM. Before the end of the connection, we
> can send a RM_ADDR for an address that is used for multiple subflows by
> the other end. Then we can check that the counter has been decreased
> only once. That's what I tried to do, but I got another issue, see [2].
> 
> [1] https://github.com/multipath-tcp/packetdrill
> [2] https://github.com/multipath-tcp/mptcp_net-next/issues/492
> 
>>  		if (!removed)
>>  			continue;
>>  
> 
> Cheers,
> Matt

-- 
Li YongLong
