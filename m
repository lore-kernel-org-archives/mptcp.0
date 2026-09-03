Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146D46F4B3
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425767; cv=none; b=SN+4OM4iZMazv5/Gb1Q0nXHpFqqhNUjl0HMUi1mI3SG06qzjwAyE9OGKEBFiC0NHNN/HJ/pQMT3mSeQWGccWFDby2NoXiZnXbwyNvH421nMPYOBGw3cKB4D0zP5OwuOgcJ8AIb0A4euUYgNBsGD+SIVnvcEABbQR1U3N287OnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425767; c=relaxed/simple;
	bh=sVBciI4TvfLRO3buQog+eBQw9MifiDkBsVxiFbJv11E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fd5Msehwl0tUIycM3Hzn5kLoj2wBoDE3E/Wdr/OwhLiQqONDDuwJQYcdHm/V51sAMCoMAydmUb8HFWGWorl+xsUeg6gVmXg/SRePWlTb+XmnpzWHTcnaFnGGnmE51RCj9neLyHTqQACdm8p0bZubbSKjOIfDX9IrrW1jak98eJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qZbcmTaW; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qZbcmTaW"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=sVBciI4TvfLRO3buQog+eBQw9MifiDkBsVxiFbJv11E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788425762; v=1; x=1789030562;
 b=qZbcmTaWvAzo2boJjmLI5ssjknMtO6JMO2ah97jfAbMDPQ07G0ANO40uIcWeNEcxWlB+9eDH
 3ROGfeJzt/lZrOerqoOSOoQhfh+gB8BPlbEe6Qx6KvYiEZIPNX/JrTLr7M+2Pc8stYeQphxjLx7
 dkNPVeu8PxfwY5EDKKz+UsmY=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 5a83903ee15aed07;
	Thu, 03 Sep 2026 08:56:02 +0000
X-Mizu-Trace-ID: 5a83903ee15aed07
X-Migadu-Flow: FLOW_OUT
Message-ID: <801d048f-70a3-4b42-8a09-7b81f46d9a22@linux.dev>
Date: Thu, 3 Sep 2026 16:55:55 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, geliang@kernel.org, cuitao@kylinos.cn,
 Quanye Yang <quanyeyang@proton.me>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: pm: bound extra_subflows admission
 on userspace PM
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20260831093206.689827-1-cui.tao@linux.dev>
 <20260831093206.689827-2-cui.tao@linux.dev>
 <c8c4f667-5d25-4d94-8627-387d4091c8c4@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <c8c4f667-5d25-4d94-8627-387d4091c8c4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Matt,

在 2026/9/3 00:39, Matthieu Baerts 写道:
> Hi Tao,
> 
> + cc Quanye
> 
> On 31/08/2026 11:32, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> mptcp_pm_allow_new_subflow() increments the u8 extra_subflows counter
>> for every accepted MP_JOIN on sockets using the userspace PM, without
>> any limit. A peer establishing more than 255 live subflows wraps the
>> counter back to 0, which then makes the underflow guards warn on the
>> next subflow close, and permanently corrupts mptcpi_subflows_total
>> reported to userspace.
>>
>> Refuse new MP_JOINs once the counter has reached U8_MAX, so that it
>> cannot wrap anymore.
>>
>> Fixes: e99c1ca89071 ("mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow")
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629
> 
> Do you have a GitHub account? Just to know if we can assign this task to
> you (or just leave a message in the comment section).
> 
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>  net/mptcp/pm.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 8b68868255c5..3990f6775723 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -562,10 +562,17 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
>>  
>>  	if (mptcp_pm_is_userspace(msk)) {
>>  		if (mptcp_userspace_pm_active(msk)) {
>> +			bool allow;
> 
> "ret" could be re-used here.
> 
>> +
>> +			/* extra_subflows is a u8: don't let a peer wrap it
>> +			 * with more than U8_MAX accepted MP_JOINs
>> +			 */
> 
> I don't think this comment is needed, "< U8_MAX" is probably clear enough.
> 
>>  			spin_lock_bh(&pm->lock);
>> -			pm->extra_subflows++;
>> +			allow = pm->extra_subflows < U8_MAX;
>> +			if (allow)
>> +				pm->extra_subflows++;
>>  			spin_unlock_bh(&pm->lock);
>> -			return true;
>> +			return allow;
>>  		}
>>  		return false;
>>  	}
> 
> So, at the end, we can re-used the same version as Quanye. Would it be
> OK for both of you to have a Co-developed-by tag here?
> 

Thanks for sorting this out with Quanye.

Sounds good to me. I'll send a v2 taking your two comments into
account, reusing "ret" and dropping the comment, with Quanye's
Netlink part as a separate patch with him as author, and
Co-developed-by tags on the admission patch. I'll switch to
"Closes:" for the issue as well.

About the GitHub account: I have one (sharkct235@gmail.com) but
honestly I don't use it much because of the captcha checks, so
sorry in advance if I'm slow to react there. I've left a comment on
the issue, and I'll try to be better at watching it for this kind
of thing.

Thanks,
Tao

> Cheers,
> Matt

