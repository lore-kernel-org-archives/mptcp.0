Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31F331A46;
	Thu, 25 Jun 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394916; cv=none; b=qiKqHWrOQuF2FN6KeTlvh380sYCp43+whnT3hn/29AgHfm3oSaBMseVWOsKPvibJl3AR03ANsTzsori0L6Ndxq/Or0Rn7+4VEyRIbSQI3SgQFBkIsBtiGi8SGA1Yb4nHpkc/5BLHrRz5RBbCPbFXjAaLHjWCoaGY7cCo3VLWgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394916; c=relaxed/simple;
	bh=TvVbeb60/PTySsK4vHDm87zawwXLaZ1FWWETz+89UmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/vtA6A+o18BPK53Dos2z/4xMORyB1PBicxIpSGAG6Yns94e6sMzxep59ZjLESVtrgaj/GLqP6U1OFhVR8mF9Pj1PsqGyGSGQ00qFSxoRBFOX7zFK/WaWH3YAcb6h/ye4GNiQ6CPidohUQ9BGr/MK9Mv/IYAHeSKWKKr3ZwPt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMgU6W1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMgU6W1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210461F000E9;
	Thu, 25 Jun 2026 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782394915;
	bh=0bWUv6aewXzurO7voPqDaKjL1PVSd5ivjKvmmQVuGwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OMgU6W1J8UaaHltkQr8yvhNuQjdCRSy/MQGMsJxZe2npaynCUYVtOsDpYxNKjj1pI
	 cWIRfq9qrx7lvhevz0losWRIyl4CnHW0RuLLKdlurT/rmi9DnaFomJlIknz5ZfIIFK
	 ObEI78dewZOdaFw3V2ZRfBuBmFFguM0i9EoJtIt+PTMlfuavg2FcshpyRh+otRQa1z
	 nL7Y48uUTkMYoXFEreFugbBOnAyQ2sZGnV80U8CiMnLXC0Si+RXOtyhN9ptWpzgPLU
	 65pS60SH+XcUDQD5ZQUg0Uqb7UP/9pyMG1e4BA0lQQE737t5T/fHj7lKWkU54hlQ8f
	 rng88+FLCtOSA==
Message-ID: <66c2d735-6ef0-4dc4-8483-c6a2e4828b28@kernel.org>
Date: Thu, 25 Jun 2026 15:41:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp:export-net 15/22] include/linux/compiler_types.h:699:45:
 error: call to '__compiletime_assert_784' declared with attribute error:
 BUILD_BUG_ON failed: sizeof_field(struct mptcp_ext, flags) != sizeof(u16)
Content-Language: fr, en-GB
To: Frank Ranner <frank.ranner@intel.com>
Cc: lkp@intel.com, mptcp@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 pabeni@redhat.com
References: <d5891e2b-2f88-480f-a61e-2fe192d413ad@kernel.org>
 <20260625130953.140040-1-frank.ranner@intel.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260625130953.140040-1-frank.ranner@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Frank,

On 25/06/2026 15:09, Frank Ranner wrote:
>> Mmh, I wonder what size this struct group has on ARM 32bit. I tried to
>> reproduce the issue with the config file and the instructions, but I
>> didn't manage to.
> 
> The size is 4 bytes there, and the reason is the ABI rather than the
> patch itself.
> 
> arm-collie_defconfig targets the StrongARM SA1100 (ARMv4):
> 
>     CONFIG_ARCH_MULTI_V4=y
>     CONFIG_ARCH_SA1100=y      # CONFIG_AEABI is not set
> 
> Because CONFIG_AEABI is not set, this config is built with the legacy ARM
> ABI (APCS-GNU / OABI). Its defining difference is
> -mstructure-size-boundary=32: every struct's size is rounded up to a
> multiple of 4 bytes (EABI uses 8).
> 
> struct_group(flags, ...) expands flags into a named sub-struct. Under
> EABI that sub-struct is 2 bytes (two u8 bitfield containers), but under OABI
> it is padded up to 4 bytes. Hence:
> 
>     sizeof_field(struct mptcp_ext, flags) == 4   !=   sizeof(u16) == 2
> 
> and the new BUILD_BUG_ON in net/mptcp/options.c fires. The report is
> therefore a genuine OABI portability issue, not a false positive.

Thank you for the analysis, I didn't know about this kconfig and its effect.

> The reason your local attempt passed is that the build reused an existing
> O=build_dir whose .config was not the OABI collie config, so the bitfield
> group packed to 2 bytes. To reproduce, regenerate the config from scratch so
> the OABI flags actually take effect:
> 
>     COMPILER=gcc-15.2.0 ~/lkp/kbuild/make.cross ARCH=arm O=build_dir collie_defconfig
>     COMPILER=gcc-15.2.0 ~/lkp/kbuild/make.cross W=1 ARCH=arm O=build_dir net/mptcp/options.o

Indeed, I confirm that.

> Suggested fix: don't assume the flags group is exactly u16-sized. Clearing
> it with
> 
>     memset(&ext->flags, 0, sizeof_field(struct mptcp_ext, flags));
> 
> instead of a 16-bit access, and dropping/relaxing the != sizeof(u16)
> assertion, makes it correct on OABI too (where the group is legitimately
> 4 bytes).

The purpose of these new BUILD_BUG_ON(), etc. was to avoid a memset().
That's a shame we have to use it for this (exotic?) option, but I guess
we would prefer that over a non-readable code using #ifdef there.

Just to avoid a deadlock: are you planning to send such patch, or do you
prefer if someone else does it?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

