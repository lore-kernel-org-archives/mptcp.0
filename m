Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415560;
	b=jmCAnEWWgizFGKzwQNUrXjMbE9tkcB0hUi8rLtrMvhBd/IocxoYtJstRRdgF7Ssk8Zxo
	 RLpInTR6qq7FbN+dUXijAfYGhabsum/bow8ge67c6bKuym2+bb6/BbuiFCO2z2ylEYgCV
	 d4/uWikwrFFtlHyZ5zn3Cb6byU3NJ2VqgSsa819Utif7E8Zqj1xeO0HuBVNi9xynKPwVy
	 qk3t6WV/kcdJRRG+1o2fuiDPC+1qunWUTSQ0PfyFhRpIfY1BbN4HYTJhZVf7MtwN4Mz1X
	 5yYAeJSs7wj4nz1GYLh6vMutU4fFA9vcTCcDWmzHCIXUCYx4rpvcAkSSC5IbStBovtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415560;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1XNa2qEm66Xf30ph/NCDcVd1toP6rRmFBkhXBjNtmoU=;
	b=q1lgz1JyhCgeU1C5G+XvYX4E1fyAKCxT05EVNoy1BLKSx9Hxpz5O6wx8XwDCVbgsGf4R
	 bPlQHDuV3YOrEW94rc1avHy8YQpJxLR9E9CgaNkPq2kCdNj/OmySezki7JI4Bvvfr3C5P
	 TfVlbpNitmL9xdpYJPbtaWc/tBg+/BXX7ylryue0VILrQfj9s1kf9iIeqtE0pwHvBTjcV
	 sS1c5PXOqcmsQdzZxUinkPfjtPfEy/4/vCI6oeDZzRJsHHz1zCOZPCyOO/CfuEJOtmTgB
	 aDq1bZVvGaQXdk6b6RqDqZ2DHhboGtnr7ac1NonajhTz9/SmmytYHTLBeGRjG34Os3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxFH3uZe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86886606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxFH3uZe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10F61F000C4;
	Mon, 23 Nov 2026 06:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415559;
	bh=1XNa2qEm66Xf30ph/NCDcVd1toP6rRmFBkhXBjNtmoU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KxFH3uZeilr5tVD2f0ifHqPqVIG29zKYk+sorqTV1kjKjVLwdy7yOLGTgQqvDs+Dg
	 qkaitDTcfZghanOSQtcp43OeyN0fhCD9NNcqiaJFGo6ihvd65Q3emyeEl8psPKuhmu
	 6Igu8dQ+5UCZzr20fpNc/yNOBaqralIrspKoiPC8sibkF48msBBsYF9dMZKL6A7Wo1
	 y0Wdy+Fk40tMIZqTbOAFbp/ePgWSvQ1QKJ80dNMfwGGbLVJp7skrv2PKX6qo42ONKR
	 XqYyW06eEt7CDd5rFDEkjTsl05HkPZs0jOi5rQuM7raVO9idEWWDKzP4Tk9e/KZLfh
	 d66fbSqo4UtOw==
Subject: Re: [PATCH mptcp-net v2 50/62] mptcp: continue the last mapping after
 a fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:39 +0000
Message-ID: <179541555937.3133.8595018877227525015@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-50-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-50-00327fd1de1f@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When only the receiver falls back, the new dummy mapping
  (`dsn_base + map_subflow_seq - 1` in subflow_check_data_avail(),…
- [Low] The MP_FAIL branch of subflow_check_data_avail()
  (net/mptcp/subflow.c) ignores the new map_old precondition.

--

mptcp: continue the last mapping after a fallback

The fallback dummy mapping in subflow_check_data_avail() now continues
from the peer's last DSS mapping (dsn_base) instead of iasn. Before this,
a zero window probe or a reinjection shifted all later data out of order.
The patch also tracks the highest end of the peer's mappings (dsn_end),
and makes mptcp_try_fallback() fail while the last mapping ends below it.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 3590c1207e88b..f73e4b8deca42 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -1438,6 +1440,17 @@ static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
>  	return true;
>  }
>  
> +/* Fallback: dummy maps go on from the last valid one, unless it is old */
> +static void subflow_update_dsn_base(struct mptcp_subflow_context *subflow)
> +{
> +	u32 end = subflow->map_seq + subflow->map_data_len;
> +
> +	subflow->dsn_base = subflow->map_seq - subflow->map_subflow_seq + 1;
> +	subflow->map_old = before(end, subflow->dsn_end);
> +	if (!subflow->map_old)
> +		subflow->dsn_end = end;
> +}

[Severity: Medium]
Can this deliver bytes twice to the application when only the receiver
falls back, even if the sender runs a current kernel?

A probe or reinjection whose map ends exactly at dsn_end moves dsn_base
but leaves map_old at 0, because before(end, dsn_end) is false.

Take two zero window probes. The receiver has DATA_ACKed up to DSN E,
so dsn_end = E, and its MPTCP window is zero:

  probe 1  SSN P,   DSN E-1, 1 byte (content of byte E), with DSS
           -> dsn_base = E - P, end = E, map_old = 0
  receiver reads and sends a window update with DSS
  probe 2  SSN P+1, DSN E-1, sent before the window update arrives,
           DSS stripped by a middlebox

Probe 2 passes the sender's reset check. Probe 1 was acked with DSS, so
opt_ack_seq is current.

On the receiver, probe 2 gets MAPPING_NODSS. mptcp_try_fallback() then
succeeds, because map_old and old_data_pending are both clear. The dummy
mapping at the end of subflow_check_data_avail() gives:

  map_seq = dsn_base + map_subflow_seq - 1 = (E - P) + (P + 1) - 1 = E

That equals ack_seq, so the probe's byte is delivered at E.

Next, the sender sends byte E onward as new data at snd_nxt. The reset
check in mptcp_sendmsg_frag() only covers old data:

    if (unlikely(before64(data_seq, msk->snd_nxt) &&
                 !test_bit(MPTCP_JOINED, &msk->flags) &&
                 after(tcp_sk(ssk)->snd_una, subflow->opt_ack_seq))) {
        ...
        mptcp_subflow_reset(ssk);

The new data does not trigger it, and the receiver, which has fallen
back, maps it at E+1 onward. Byte E is delivered twice and every later
byte is shifted by one.

The sender only resets later, when its MPTCP rtx timer reinjects old
data. By then the shifted data has already reached recvmsg(). Before this
patch, probe 2 was mapped at E+1 and went to the out-of-order queue, so
the connection stalled instead.

Two reinjections seem to allow the same thing. The first one, seen with
DSS and ending exactly at dsn_end (for example a spurious
__mptcp_retrans() after a stale DATA_ACK), moves dsn_base. The second one
has its DSS stripped and gets dummy DSNs starting at dsn_end, so its old
bytes are delivered as new.

The commit message says:

  "it now delivers data resent at the MPTCP level as new data, unless the
  sender resets the subflow before, as it does since "mptcp: don't resend
  data acked without MPTCP opts"."

Does that still hold when the sender's next transmission after the
stripped resend is new data and not old data?

Later in the series, "mptcp: reset when the DSS disappears after a
DATA_ACK" makes NODSS fatal only when subflow->dss_confirmed is set. A
receiver that never sent data of its own, such as a download client,
still looks exposed.

> +
>  static bool subflow_check_data_avail(struct sock *ssk)
>  {

[ ... ]

> @@ -1501,6 +1516,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
>  				goto reset;
>  			}
> +			subflow_update_dsn_base(subflow);
>  			WRITE_ONCE(subflow->data_avail, true);
>  			return true;
>  		}

[Severity: Low]
Should map_old be checked here, before this branch commits to a graceful
MP_FAIL?

For MAPPING_BAD_CSUM, mptcp_subflow_fail() only checks
msk->allow_infinite_fallback and msk->first. It then clears
allow_subflows, sends MP_FAIL without RST and arms fail_tout.

Only after that does subflow_update_dsn_base() run on the bad checksum
map. If that map is a reinjection of old data ending before dsn_end,
map_old becomes 1 after the fallback has already been promised.

The peer answers from mptcp_pm_mp_fail_received() with an infinite
mapping. On the receiver, that leads to:

subflow_check_data_avail()
  get_mapping_status()   /* data_len == 0: MAPPING_INVALID here,
                            MAPPING_INFINITE later in the series */
  goto fallback
  __mptcp_check_fallback(msk)   /* still false */
  mptcp_try_fallback()
      if (subflow->map_old && !__mptcp_check_fallback(msk))
          return false;
  goto reset                    /* MPTCP_RST_EMPTCP */

The subflow is then reset with MPTCP_RST_EMPTCP one round trip later,
after the peer has already fallen back.

Could this branch test map_old right after updating it, and take the
existing goto reset path with MPTCP_RST_EMIDDLEBOX, as the
!mptcp_subflow_fail() case does?

Hitting this needs DSS checksums. It also needs a reinjection of old data
on the only subflow that stops before dsn_end while the peer's
allow_infinite_fallback is still set, for example
__mptcp_retransmit_pending_data() after a failed MP_JOIN. Finally, the
payload of one of the old maps must be corrupted on the path.

At the end of the series, "mptcp: reset when the DSS disappears after a
DATA_ACK" still leaves this MP_FAIL branch unchanged.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
