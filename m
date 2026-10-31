Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446231;
	b=BAhel3wrt/7J7E/rPdAAFppUfQ3gABTVpsrFft6fNJ7iPwVDRliAr53VGaW/b0i5GMuG
	 0pV+6Hla3q6PduqAyCH0ufpRmFPa6cjOzHk42O7JMzapxbWgE9pZg2BE0zCYk/tABpsbr
	 xeRYCoijuJ+2NQUnfBizkJe2B8c/ePA/H+/phXfHtRk8H5NDtwppVF+Rzoi5t2DB8k1Sl
	 cQXdkaT8silKkHJr4QOH5a9AMPB3Udc6YnXssdOl+/Gn9plaCAGPF3fgWkwISY/bbB01N
	 +beneSfaPimTN5Rz061ga2WHuTC3VD5YMQ02dp6AG/9lmkkX/D09BJ3BVed+3oTJLhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446231;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cvJ+zh6ILTT9UIbuV4UHpgGpU8uXRrIcgicMYbsEpIQ=;
	b=vDEvx85wQftc2/mNosLmi4bYdUcFL1NxQNPI7Zwl1IlNVJ0YglGY2W8zZFdEI24CByKX
	 +JQv1xdQCGZ1K98BoYQzzieiHmZKmfbQnxbCLsPc83wgA3FzQIXrTCWyo6PM+936ydLoE
	 OxZehN0TIW6/kYV6ekqmadjheUIkJ0UsSGXhk25gWCPOXa21+DhEkT3MCTVktj6mp1Wxm
	 Yv0nGVYUCPtltszPmpIgs7WJBs+jr3j/D7j0lIOhEYSVJvDytVXzVkCSNb8FzYwMPRiOA
	 sokFF2z1gdHqioOgOrqUyDTz/WX0mGSQt21kHBhE03cEN9ERomdB8w1tBG2fQ2zdVNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZA/gmRVE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69359606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZA/gmRVE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1CB1F0093A;
	Sat, 31 Oct 2026 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793446231;
	bh=cvJ+zh6ILTT9UIbuV4UHpgGpU8uXRrIcgicMYbsEpIQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZA/gmRVEDnAYEUYjx8GD0QD4lkF6GxKHFxqIj3vNtFZ4TA7IbRMBScAbOA6/Qjqmi
	 UuYNqLW3qaIC6DMwgdI7ProeU/f8XIQFDHuuaS9m+UyplYW0PBN7EIlGMbh5It4ObL
	 rT1q9++HY0tltr41bi0N2gFBayV+lrk4Z2MIIAoD9b0IzpMq/t/lZModXshtq3UD3a
	 D6DEJygWYW6q7r/SLNbRULvutFErzHHRki90/meeeYS75KqgjQkkqUunzYwRkvex6o
	 LHenUXb+xnLBNx+yhagmzxMjdrVq1Y8q8g7OuwlLdaznBX3v2WntK5o2FWu5zs8LiQ
	 VsUKEYlT1IHug==
Subject:
 Re: [PATCH mptcp-net v4 6/8] mptcp: pm: userspace: don't dump initial ID0
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 11:30:30 +0000
Message-ID: <179344623049.3128.433912421519045672@kernel.org>
In-Reply-To:
 <20261029-mptcp-pm-userspace-id0-case-v4-6-555066fa4292@kernel.org>
References:
 <20261029-mptcp-pm-userspace-id0-case-v4-6-555066fa4292@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "If the address is removed, then re-
  added later with a new subflow, it can be dumped." The code does not…
- [Medium] This patch hides the initial ID0 entry from
  MPTCP_PM_CMD_GET_ADDR dumps to avoid changing previous behaviour and…

--

mptcp: pm: userspace: don't dump initial ID0

An earlier patch in the series adds the initial ID0 local address to the
userspace PM local address list. This patch skips that entry in the
MPTCP_PM_CMD_GET_ADDR dump, so the dump output stays as it was and matches
the in-kernel PM.

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 0f6400bc3bf8e..282d7f57c32ab 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -637,7 +637,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  	lock_sock(sk);
>  	spin_lock_bh(&msk->pm.lock);
>  	mptcp_for_each_userspace_pm_addr(msk, entry) {
> -		if (test_bit(entry->addr.id, bitmap->map))
> +		if (is_init_id0(entry) || test_bit(entry->addr.id, bitmap->map))

[Severity: Medium]
The commit message says:

  If the address is removed, then re-added later with a new subflow, it
  can be dumped.

Does the code do that? is_init_id0() only checks the id and the port:

static bool is_init_id0(struct mptcp_pm_addr_entry *entry)
{
	return entry->addr.id == 0 && entry->addr.port == 0;
}

mptcp_pm_userspace_created() memsets the initial entry and sets port to 0.
Nothing else marks it, so it looks the same as an ID0 entry that userspace
adds later.

Take this sequence:

  MPTCP_PM_CMD_REMOVE, loc-id 0
    mptcp_pm_nl_remove_doit() deletes the initial entry

  MPTCP_PM_CMD_SUBFLOW_CREATE, laddr id 0, no local port
  (or MPTCP_PM_CMD_ANNOUNCE, id 0, no port)
    mptcp_pm_parse_entry() memsets the entry, port stays 0
    mptcp_userspace_pm_append_new_local_addr(msk, &entry, false)
      keeps id 0

The re-added entry has id 0 and port 0. Wouldn't every dump skip it, even
though GET by id, RM_ADDR and the local ID lookup still find it?

The other claim, "Not to change the previous behaviour", also looks wrong
for ID0 entries that userspace creates. Before this series, a
SUBFLOW_CREATE with lid 0 and no port appeared in the dump. The old
selftest checked for "id 0 flags subflow 10.0.3.2". With this patch that
entry is never dumped. It is only dumped if userspace sets a non-zero
local port.

The v3 changelog says the v2 flag-based check was replaced by this id/port
check, but the commit message wasn't updated. Could the initial entry be
marked explicitly in mptcp_pm_userspace_created()? The other option is to
reword the commit message to say that all ID0 entries with port 0 are
hidden.

A later patch in the series, "selftests: mptcp: join: new ID0 subflow from
the right IP", changes the selftest to expect an empty dump. That fixes the
selftest. It doesn't fix the mismatch between the code and the commit
message, or the uAPI change that the message doesn't mention.

>  			continue;
>  
>  		if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)

[Severity: Medium]
Should mptcp_userspace_pm_get_addr() also filter the initial ID0? The do
path of MPTCP_PM_CMD_GET_ADDR still looks up id 0 with no is_init_id0()
check:

net/mptcp/pm_userspace.c:mptcp_userspace_pm_get_addr() {
    ...
	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
	if (entry) {
		*addr = *entry;
		ret = 0;
	}
    ...
}

mptcp_pm_userspace_created() now adds the initial address to the list. So
a GET_ADDR with a token and id 0 always returns that address. Before this
series, the same request failed with -EINVAL unless userspace had created
an ID0 entry.

The in-kernel PM never returns id 0 here. mptcp_pm_nl_get_addr() ->
__lookup_addr_by_id() only searches the endpoints, and endpoint IDs start
at 1.

For the same connection, the dump now hides an entry that GET returns. Is
that split intended? If it is, could the commit message say so? The
"previous behaviour" and in-kernel PM reasons are only applied to the dump.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292%40kernel.org
