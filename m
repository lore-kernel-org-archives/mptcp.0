Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6C25DD17
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737091; cv=none; b=C6TbjwCV5R1Xvx1ghMPmXmA90X/3CZEnDOG/zOed5n6fyXSC1/RtG4gaS+QNiOmm/W4IAgrqAab2g5nJ9/CeTD+SdHgAl04tGW+L8fBFHw2EVZaMPfOfYrwkO0urGllRZHSgtNQIr545X/L5X5+JJYzKI0N9OFnRr2GofARJlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737091; c=relaxed/simple;
	bh=tlJ7xwpDpgP6mMSfU71o7CJFErr165zhks3jTurEFs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uA4t8Q1Qu63CLboieLmt3Fqc0lUoD4CphbgxsRoZeolboSCsAX8S+jZoux19747V1qu7Pf5/E4xw+KO07PbAVNZr0WIToOHOivCoaZ0As6rGjWhUwMW7VkfEjlbDW4hdg8iH3lT1arxg3iwLy3/a5ItLuNhjBcM2tVWybhpfa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIczYc1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIczYc1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7891DC4CED6;
	Fri, 28 Feb 2025 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740737091;
	bh=tlJ7xwpDpgP6mMSfU71o7CJFErr165zhks3jTurEFs4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aIczYc1ZYOV6YngpPcUJeXembBAOxoBG/pkgCWOW4DgyelwfVrBhcoPXhoOW+O/wk
	 BdkOQ7bfXA4adXFt+02+E7Bz3KqO0Aszb55WSpE8zvBX99vcOO1+DTA3hL+AGmTRx5
	 CXCmrmBpx9eV1RZBNhwsfg33SV2/5fweDO5K4f7WPZjO5tb+kjYlPV0hY4ebS5SCHl
	 c4h6V5+v0bJ1HqDt1jX+mbbenAn91u3n2neVIZsfKs6NyCdYOq3cohBzbxHEwqgfFW
	 gngZJCPMxH5ta6qdmEelunuFqzuHmd85J81a/bgKfl6/W7ONhWYMSV6Znz+c85PY63
	 0q21mFXSDWUDQ==
Message-ID: <92404248-082b-4b2f-859e-e32455c9c131@kernel.org>
Date: Fri, 28 Feb 2025 11:04:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 7/7] mptcp: pm: code reorganisation
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
 <20250227-mptcp-pm-reorg-code-v1-7-cb4677096709@kernel.org>
 <a3494c6ec1ad087a74b3c1c6241e18c9f9787078.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a3494c6ec1ad087a74b3c1c6241e18c9f9787078.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/02/2025 03:14, Geliang Tang wrote:
> Thanks for this set, it's useful for me to implement mptcp_pm_ops.

Great, I hope it is!

I will move the renaming to different patches as you suggested.

> On Thu, 2025-02-27 at 21:08 +0100, Matthieu Baerts (NGI0) wrote:

(...)

>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index
>> 8742527196887598eb242c82f06004107d29ef92..380b61be4cf65bc42f791bf2254
>> c8a2b4aa333fe 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h

(...)

>>  void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
>>  			      const struct mptcp_addr_info *addr);
>> -void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
>> -bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
>> -				     const struct mptcp_addr_info
>> *remote);
>> +void mptcp_pm_send_ack(struct mptcp_sock *msk,
>> +		       struct mptcp_subflow_context *subflow,
>> +		       bool prio, bool backup);
>>  void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
>> +void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id);
> 
> I propose to add a new patch to rearrange the function declarations in
> this header, grouping the functions in pm.c together, and grouping the
> functions in pm_netlink.c, pm_userspace.c, and pm_kernel.c separately.
> WDYT?
I don't know: I think protocol.h is a bit of a mess, not only around the
pm files. We should have probably added one header file per associated
.c one from the beginning.

It is then tempting to re-order that too, but I think it is too late: if
we do that for all files, that will cause conflicts during backports,
and conflicts in such files will be a nightmare I think, easy to miss
one or something like that.

At the end, protocol.h just contains a lot of function signatures, semi
ordered, and we can probably live with it. I don't think it is then
worth it to reorder it now, I don't think that will help with the long
term maintenance. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

