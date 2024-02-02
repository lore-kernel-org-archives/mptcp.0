Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC67145328
	for <mptcp@lists.linux.dev>; Fri,  2 Feb 2024 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885503; cv=none; b=O+jhEvEC+r08rtU46h4C7WwOLMlBPo45Q3dLm+flm108jfdyYPlAljj0AOI92JmmaD/OVF/MzZnoI/HwI3TbIhGYHPF3CQtQvQzkoRl0o0Ppt0E/gaBvf05o6NVVHPKshSzufY0AbjFnLAAgaj2MyuJ8kdZOg6x0Rf9YiI2Gli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885503; c=relaxed/simple;
	bh=tHGKUh8HrEodLau2nqobTQwhqeDmlkfLD/mG7x96+OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUxxsQwnIrKE0R9Q2IWQ1erORn9YOzMcxCLk5zKxapyB4HUbkr9w8HrQx4EpQqlOwK88awmCJf9Gfi40ttLDSMk7NkjaWYZNHlpFcivqUM66nhbHK/7jDBmowkYdmjdmrCBwgLyKjaMouUg84LKeOPT8NVGvaM+gXomBXWqQOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQXn1Fwz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQXn1Fwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A311C433A6;
	Fri,  2 Feb 2024 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706885502;
	bh=tHGKUh8HrEodLau2nqobTQwhqeDmlkfLD/mG7x96+OQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DQXn1Fwz/0Uol/5691BNdNmdTA1KnkXeXXRHSlZtQjumJuP8LgX1d4xWtMIwtHfx5
	 LYgpLF8u38js1po4wMuvTUlR8TcCz8XEbtFyAeYyJHMFkHY73IzuymjufF8dqetMpA
	 4Ahr/73RNYwwJ7QRX202etQbcPasaPBrRD2sI+gKmgfXDIE+w3c9tDhzGjgbojCiFL
	 Q1EHD6+m1ckTn9wONGtAGoJ/6vArJuMRSBjM0FDXALT22X1FLI2qnPynAQzheIBypc
	 yVv0Z+/d0E34HQaGEKFuKV52JL1JUZhfUPIvg07tYjW+biGOrhNLxzRv/i8aWn0aLh
	 qXWBDs1k2QOkw==
Message-ID: <a28ac39d-aa4f-4672-87b8-aabf39539601@kernel.org>
Date: Fri, 2 Feb 2024 15:51:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v14 00/25] userspace pm enhancements
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
References: <cover.1702029538.git.geliang.tang@linux.dev>
 <e136346b-936f-9f63-50a0-788bef0f276e@kernel.org>
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
In-Reply-To: <e136346b-936f-9f63-50a0-788bef0f276e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Geliang,

Sorry for the delay.

On 09/12/2023 02:15, Mat Martineau wrote:
> On Fri, 8 Dec 2023, Geliang Tang wrote:

(...)

>> Part 5: address entry refcount for userspace pm (patches 19-25)
> 
> These patches are to address
> https://github.com/multipath-tcp/mptcp_net-next/issues/403, correct?
> 
> I think a refcount is not necessary to make the userspace local address
> list work correctly.
> 
> The userspace local address list should contain:
> 
>  * An entry for ID 0 (when the connection is started - it may be removed
> later)
> 
>  * An entry for every ID advertised with ADD_ADDR
> 
>  * An entry for every ID allocated by the kernel when an outgoing
> MP_JOIN uses an address that doesn't have an existing ID.

Yes, I agree with that: it is required to track all explicit (ADD_ADDR)
and implicit (MPC + MPJ) addresses. Technically, we don't need a single
list for that, as long as there is a helper function to look at all
these addresses.

> Entries should only be deleted by a "remove" netlink command from the
> userspace PM daemon. Closing subflows (or connection errors) should not
> remove entries from the local address list.

Correct, only when sending a REMOVE_ADDR. Indeed, the PM might want to
delete a subflow for some reason (e.g. saving bandwidth), but it doesn't
mean the address became unavailable.

> Does anyone remember why the current code deletes address ID entries
> when subflows are destroyed or connections fail?

I wonder if there were not some confusions with pm.local_addr_used
counter. We might want to know the "actual" status, but it is true that
it should show what has been announced, and not what is being used.

For the destroyed, that's indeed not correct: we should then not remove
the entry.

For the connections fails -- not able to queue the SYN+MPJ in
__mptcp_subflow_connect() from mptcp_pm_nl_subflow_create_doit() --,
that's maybe different, no? Nothing has been sent on the wire, maybe the
new address entry should be removed? But for this specific case, we
don't need a refcount, we can add the entry after having called
__mptcp_subflow_connect or we modify
mptcp_userspace_pm_append_new_local_addr() to also tell us if a new
entry has been created.

> If the local address list is defined as "the list of address IDs we have
> advertised to the peer", there is no need to manage the list as subflows
> are added and removed. Even when no subflows currently exist, the peer
> still can have cached address IDs from our device, so they must be
> considered valid until we send a REMOVE_ADDR.

Agreed.

> I suggest modifying the userspace local addr code to make '0' valid. If
> there's a need to track whether the ID is unassigned, maybe struct
> mptcp_addr_info needs a separate flag for that.

Good point, thank you for having spotted that.

So, if I'm not mistaken:

- mptcp_pm_nl_subflow_create_doit() should *not* call
mptcp_userspace_pm_delete_local_addr() or *only* remove the entry if it
has just been created before.

- mptcp_pm_nl_subflow_destroy_doit() should *not* call
mptcp_userspace_pm_delete_local_addr()

- mptcp_pm_nl_remove_doit() should call
mptcp_userspace_pm_delete_local_addr() (which might need to be modified)

- We should replace this comment above
mptcp_userspace_pm_delete_local_addr()...

/* If the subflow is closed from the other peer (not via a
 * subflow destroy command then), we want to keep the entry
 * not to assign the same ID to another address and to be
 * able to send RM_ADDR after the removal of the subflow.
 */

... by something like: Only remove entries from the local addr list if
the address has been explicitly removed via a REMOVE_ADDR. Removing a
subflow doesn't mean the address became unavailable.

- We should remove the TODO about the refcount in
mptcp_userspace_pm_delete_local_addr()

- And close https://github.com/multipath-tcp/mptcp_net-next/issues/403


@Mat / Geliang: Is this correct? WDYT?

@Geliang: is it something you were already looking at?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
