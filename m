Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C242F0C52
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618345; cv=none; b=qUlch/jeozmY3WQOgB5Bs7+qIlwuVgLeQjYeRLsuIZoBLBgae26SnAKskcczH+DbPyWmuCo58b3i37CXxIrlV7X+ObGZIVnXPR48PwtfmVkHt5vyMHqGMBGoycyH74bsDTMV+/N7T+OkN/UmydzsblSHbGaWGS7Jqaq8pEgE2MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618345; c=relaxed/simple;
	bh=N3n9GYbuUKaDz1X37gVT2yXsAx2PB2qZNu8o586xkVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3bmKISyJgSvutFmbHcNbwzhnjkk/e7UIz5KVmHcVO9HwbyPPUBjbIvdLG+2l7DWeL/c5IInNQmeCPqoF+Ao6TeADzsJoQZde18Fh3/a6CibvZm4d9goB4epDsNsyz4A4FcYOGKKibDnjGwxG8BcYdktmnEdySNajseS2drLkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahAMxNox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahAMxNox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2836C4CEF5;
	Tue, 23 Sep 2025 09:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758618345;
	bh=N3n9GYbuUKaDz1X37gVT2yXsAx2PB2qZNu8o586xkVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ahAMxNoxKOBI9zjPc3GV6D4j7GX2lNS2IOcG2jXDmQ3jd7VTzA1oYdJ9JVQXveBTZ
	 iOCq3BQXB66biGvd1Yt0La/+T6+vU/iER+oWWco/dz3xw+dJigk3V6Od0fsMKOySZ/
	 46gjMKFoQ+6RnmqxwwGopUzMBesABtyxwl5OqrKlzCbjvZpsGj32dpQORBKcbf2I+Z
	 unXGyHqL3+euZdEvZUXTiKANYjru9OyAGZ3yLfbHJcTL56xT7UKRP9Q70jdOvVwRsD
	 uUMNo6Rc7pjQe0EmWgNFduKm0FYKLvZwatiW0DlNff3wspR30uDBAM1Xr+cV6t6ZSK
	 bXmYORael376A==
Message-ID: <ab0cd497-5e48-44f1-8e4b-d6e2aeda3fff@kernel.org>
Date: Tue, 23 Sep 2025 10:05:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 5/6] mptcp: pm: in-kernel: add 'address'
 endpoints
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
 <20250923-pm-kern-endp-add_addr-new-v1-5-60e3a8968f45@kernel.org>
 <777986f5-0f6a-ccea-28b4-be8e23806567@kernel.org>
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
In-Reply-To: <777986f5-0f6a-ccea-28b4-be8e23806567@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 23/09/2025 06:17, Mat Martineau wrote:
> On Tue, 23 Sep 2025, Matthieu Baerts (NGI0) wrote:
> 
>> Currently, upon the reception of an ADD_ADDR (and when the fullmesh flag
>> is not used), the in-kernel PM will create new subflows using the local
>> address the routing configuration will pick.
>>
>> It would be easier to pick local addresses from a selected list of
>> endpoints, and use it only once, than relying on routing rules.
>>
>> Use case: both the client (C) and the server (S) have two addresses (a
>> and b). The client establishes the connection between C(a) and S(a).
>> Once established, the server announces its additional address S(b). Once
>> received, the client connects to it using its second address C(b).
>> Compared to a situation without the 'address' endpoint for C(b), the
>> client didn't use this address C(b) to establish a subflow to the
>> server's primary address S(a). So at the end, we have:
>>
>>   C        S
>>  C(a) --- S(a)
>>  C(b) --- S(b)
>>
>> In case of a 3rd address on each side (C(c) and S(c)), upon the
>> reception of an ADD_ADDR with S(c), the client should not pick C(b)
>> because it has already been used. C(c) should then be used.
>>
>> Note that this situation is currently possible if C doesn't add any
>> endpoint, but configure the routing in order to pick C(b) for the route
>> to S(b), and pick C(c) for the route to S(c). That doesn't sound very
>> practical because it means knowing in advance the IP addresses that
>> will be used and announced by the server.
>>
>> In the code, the new endpoint type is added. Similar to the other
>> subflow types, an MPTCP_INFO counter is added. While at it, hole are now
>> commented in struct mptcp_info, to remember next time that these holes
>> can no longer be used.
> 
> Hi Matthieu -
> 
> I think this patch brings up a few larger topics of discussion: path
> manager strategy (in-kernel/userspace/bpf), interaction of in-kernel PM
> flags, and (once again!) naming.
> 
> I'm not sure the reply chain for this patch is the right place to have
> the discussion, but adding another in-kernel PM "mode" makes me think we
> need a community-level (MPTCP) discussion on our path manager strategy.
> The original plan was to have a single general in-kernel PM, and rely on
> userspace/mptcpd for anything else. We've obviously made some changes to
> that plan, adding fullmesh and having the BPF PM in progress. This has
> made path management more complex to understand, use, and maintain - so
> I want to be sure we are making a careful choice about which PM features
> to add.

Good point!

(Regarding the BPF PM, it is similar to the userspace PM, but can be
used in environment handling loads of connections in parallel ; and it
introduces a better separation between the different PMs, which makes it
worth it for the maintenance to me.)

> Our userspace API for the in-kernel PM also makes it complicated to
> explain what happens when there is a mix of endpoint types. Typical use
> would probably be reasonable (all fullmesh, all 'address', etc). But
> it's good to avoid confusion, and more importantly bugs!

Indeed, I fixed quite a few issues and inconsistencies last year, around
the same time I opened this issue #503.

I have to admit that the 'fullmesh' mode added quite a bit of unexpected
complexity for such a niche use-case (but it allows "workarounds"). I
think the new mode suggested here is simple, targeting one specific part
of the code (an ADD_ADDR is received) and fix the lack of control on
what source IP address is used to create new subflows when an ADD_ADDR
is received. Not as invasive as the 'fullmesh' one.

> As for naming, unfortunately "address" is a very frequently used word in
> our subsystem! In mptcpd the similar plugin is called "sspi" (single
> subflow per interface). I'm definitely open to other ideas that are
> identifiable and descriptive.

Me too! I initially picked "add-addr", but I wasn't happy with the minus
sign, nor by its name. I guess a good name could be "endpoint used when
an ADD_ADDR is received", or maybe "received-add-addr", but that seems
too long, and more than one word.

I ended up picking "address", because it is short, and similar to
"signal" and "subflow" (which are not very clear, but hard to do better
with one word...).

> I think there are good use cases for this feature, that's why we
> included the similar feature in mptcpd! I'd like to get our core group
> (you, me, Geliang, and Paolo) aligned on a general direction for path
> management, does that sound reasonable?

Yes indeed, it is important.

To be honest, I thought we already had this discussion at the meeting
following the opening of this ticket #503, but that was a bit more than
one year ago. I started working on it because the lack of control on
what source IP address is used to create new subflows when an ADD_ADDR
is received came back in a few discussions, even prior #503. Even
recently when a client wanted to use dedicated interface per path. It
feels like something is missing in this in-kernel Netlink API to use
endpoints to create subflows to addresses announced by the server.

But yes, we are exposing a new option to the userspace, and if it is
accepted -- and not modified/reverted in the new 10 weeks -- we will
have to maintain it for a long time. So better not to get it wrong. I
think it is "self-contain" and worth it. I would like a better name than
"address", but I didn't find one. At the end, I'm happy with it as it is
similar to the others and will have a longer description in the doc, but
I'm open to another name :)


> One technical question down below too
>  |
>  v
> 
> 
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/503
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> include/uapi/linux/mptcp.h |  6 +++-
>> net/mptcp/pm_kernel.c      | 82 ++++++++++++++++++++++++++++++++++++++
>> ++++++++
>> net/mptcp/protocol.h       |  1 +
>> net/mptcp/sockopt.c        |  2 ++
>> 4 files changed, 90 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>> index
>> 5ec996977b3fa2351222e6d01b814770b34348e9..65dc069e9063325ad2e1ffb1da21cc4a4b6efd32 100644
>> --- a/include/uapi/linux/mptcp.h
>> +++ b/include/uapi/linux/mptcp.h
>> @@ -39,6 +39,7 @@
>> #define MPTCP_PM_ADDR_FLAG_BACKUP        _BITUL(2)
>> #define MPTCP_PM_ADDR_FLAG_FULLMESH        _BITUL(3)
>> #define MPTCP_PM_ADDR_FLAG_IMPLICIT        _BITUL(4)
>> +#define MPTCP_PM_ADDR_FLAG_ADDRESS        _BITUL(5)
>>
>> struct mptcp_info {
>>     __u8    mptcpi_subflows;
>> @@ -51,6 +52,7 @@ struct mptcp_info {
>>     #define mptcpi_endp_signal_max mptcpi_add_addr_signal_max
>>     __u8    mptcpi_add_addr_accepted_max;
>>     #define mptcpi_limit_add_addr_accepted mptcpi_add_addr_accepted_max
>> +    /* 16-bit hole that can no longer be filled */
>>     __u32    mptcpi_flags;
>>     __u32    mptcpi_token;
>>     __u64    mptcpi_write_seq;
>> @@ -60,13 +62,15 @@ struct mptcp_info {
>>     __u8    mptcpi_local_addr_max;
>>     #define mptcpi_endp_subflow_max mptcpi_local_addr_max
>>     __u8    mptcpi_csum_enabled;
>> +    /* 8-bit hole that can no longer be filled */
>>     __u32    mptcpi_retransmits;
>>     __u64    mptcpi_bytes_retrans;
>>     __u64    mptcpi_bytes_sent;
>>     __u64    mptcpi_bytes_received;
>>     __u64    mptcpi_bytes_acked;
>>     __u8    mptcpi_subflows_total;
>> -    __u8    reserved[3];
>> +    __u8    mptcpi_endp_address_max;
>> +    __u8    reserved[2];
>>     __u32    mptcpi_last_data_sent;
>>     __u32    mptcpi_last_data_recv;
>>     __u32    mptcpi_last_ack_recv;
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index
>> fbd0a4ade8469ee75d99083bf640ad91a6fb714e..790dd7bc7f79e95a1fb73cbfb065087aa28f8f4b 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -21,6 +21,7 @@ struct pm_nl_pernet {
>>     u8            endpoints;
>>     u8            endp_signal_max;
>>     u8            endp_subflow_max;
>> +    u8            endp_address_max;
>>     u8            limit_add_addr_accepted;
>>     u8            limit_extra_subflows;
>>     u8            next_id;
>> @@ -61,6 +62,14 @@ u8 mptcp_pm_get_endp_subflow_max(const struct
>> mptcp_sock *msk)
>> }
>> EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_subflow_max);
>>
>> +u8 mptcp_pm_get_endp_address_max(const struct mptcp_sock *msk)
>> +{
>> +    struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
>> +
>> +    return READ_ONCE(pernet->endp_address_max);
>> +}
>> +EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_address_max);
>> +
>> u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
>> {
>>     struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
>> @@ -451,6 +460,66 @@ fill_local_addresses_vec_fullmesh(struct
>> mptcp_sock *msk,
>>     return i;
>> }
>>
>> +static unsigned int
>> +fill_local_addresses_vec_address(struct mptcp_sock *msk,
>> +                 struct mptcp_addr_info *remote,
>> +                 struct mptcp_pm_local *locals)
>> +{
>> +    struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
>> +    DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
>> +    struct mptcp_subflow_context *subflow;
>> +    struct sock *sk = (struct sock *)msk;
>> +    struct mptcp_pm_addr_entry *entry;
>> +    struct mptcp_pm_local *local;
>> +    int i = 0;
>> +
>> +    /* Forbid creation of new subflows matching existing ones, possibly
>> +     * already created by 'subflow' endpoints
>> +     */
>> +    bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
>> +    mptcp_for_each_subflow(msk, subflow) {
>> +        struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> +
>> +        if ((1 << inet_sk_state_load(ssk)) &
>> +            (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING |
>> TCPF_CLOSE))
>> +            continue;
>> +
>> +        __set_bit(READ_ONCE(subflow->local_id), unavail_id);
>> +    }
>> +
>> +    rcu_read_lock();
>> +    list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
>> +        if (!(entry->flags & MPTCP_PM_ADDR_FLAG_ADDRESS))
>> +            continue;
>> +
>> +        if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
>> +            continue;
>> +
>> +        if (test_bit(mptcp_endp_get_local_id(msk, &entry->addr),
>> +                 unavail_id))
>> +            continue;
>> +
>> +        local = &locals[i];
> 
> Looks like 'i' is always 0 here, since the only code path from here
> leads to 'break'. Would be clearer to hardcode 0 and clarify the
> variable name for the return value.

Good idea! I can also rename the function.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

