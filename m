Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30127483BEB;
	Thu, 13 Aug 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633000; cv=none; b=kjbGZlWSNHgJBtzTR652DTGodX7EfZdFO/oE1ffNDTkbaePu9tzUSV7HJ3DhULDUotbtx32Utc8JX2G+W/KBjT30Z2MypFHfAeMR7XRcwVnQzOxkRUzFOsFZAxl1NEMu84Gcquc94/uEGUkI+JHGWrWhIIc2J+25XoDpZH8uQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633000; c=relaxed/simple;
	bh=T0MK+X8oh21PIx12UhYCVcG2dVBqeWP54jxkuP2hZX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gc+MpX1EHpSEWsyLmgJYGW7FV5v32YQA36EavDBRG2rE51uPoOkcXxqVgGEiH3GbMUFUbJttXiK8KuizvbCxzyaFVCwX6KhTNY5df01aEz9bX1aPo+9wXl6tWukziPFeIagKYONoP8Ulsi+wtXOQNgR39M8edXjsiJr5SqftryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk2znR0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk2znR0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BB31F000E9;
	Thu, 13 Aug 2026 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786632994;
	bh=COvl6ITeCs6Aiy+cyG4VLkbZethQIP3a/feOqbjCzEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kk2znR0e8TXC+WU4H1KiwS8fpHZNSaR5KesKpUa6aINw+tYPDWI/5ZdTu0s3DDe9F
	 0jajjCflXLAXCXm1hyMckAOInwtd66tiAbg924rJeOhKVGu/sYDlyM+DeyZhGemCTG
	 d+qa6liuTr+8bAWZti9faj8ZNfqA0en4ggtxVvQHPK+oDnsRP8qK1MvRW6UZjNBdZc
	 HxvBGV6QZSxUsL8ShAxFLtSeQ7zAvCu0VxcepSmtCECqwUTqTXuh9vxelXz22GhcrR
	 KoVkVxJtT1kFtg/rrl4/xGxErvKcofU1fH53ZpkTTQnQhMXyeTlz6zNyXOLIC+6Oug
	 QyGfSTOdBpqTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 02/11] mptcp: remove unused data_ack from
 struct mptcp_ext
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-2-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
 <20260812-net-next-mptcp-misc-feat-7-3-v1-2-1905a818f6cb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:56:33 +0000
Message-Id: <20260813145634.20BB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] When transmitting an MPTCP DATA_FIN DSS option without a data pa=
yload (e.g., on a pure ACK), the stack-allocated `opts.mptcp.ext_copy.csum`=
 is left uninitialized. If MPTCP checksums are enabled, this uninitialized =
memory is written to the TCP header, leaking 2 bytes of kernel stack memory=
 over the network.
--

--- Patch [2]: [PATCH net-next 02/11] mptcp: remove unused data_ack from st=
ruct mptcp_ext ---
commit 5596db7582bd748ad6320aef70bbdd448c28de36
Author: Geliang Tang <geliang@kernel.org>

mptcp: remove unused data_ack from struct mptcp_ext
   =20
The data_ack and data_ack32 fields in struct mptcp_ext are no longer used
anywhere. Remove them from the structure and update mptcp_dump_mpext()
trace helper accordingly. Drop the data_ack field from the trace entry
and the corresponding output in TP_printk().

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 71b9fc5a57963..485d55b66ea67 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -19,10 +19,6 @@ struct seq_file;
> =20
>  /* MPTCP sk_buff extension data */
>  struct mptcp_ext {
> -	union {
> -		u64	data_ack;
> -		u32	data_ack32;
> -	};
>  	u64		data_seq;
>  	u32		subflow_seq;
>  	u16		data_len;

[Severity: Medium]
This is a pre-existing issue, but does this structure leave the csum field
uninitialized on the stack under certain conditions?

When transmitting an MPTCP DATA_FIN DSS option without a data payload (e.g.,
on a pure ACK), the stack-allocated opts structure in=20
net/ipv4/tcp_output.c:__tcp_transmit_skb() is not fully zeroed:

    struct tcp_out_options opts;

If mpext is NULL, net/mptcp/options.c:mptcp_established_options_dss() only
clears the bitfield flags:

    /* Zero `use_ack` and `use_map` flags with one shot. */
    memset(&opts->ext_copy.flags, 0, sizeof(opts->ext_copy.flags));

This leaves opts->ext_copy.csum uninitialized. The code then passes this to
net/mptcp/options.c:mptcp_write_data_fin(), which populates fields like
data_fin and data_seq but fails to initialize the csum field.

Finally, in net/mptcp/options.c:mptcp_write_options(), it reads the
uninitialized csum when writing the TCP header:

    put_len_csum(mpext->data_len,
                 (mpext->data_len ? mptcp_make_csum(mpext) : 0),
                 ptr);

Could this uninitialized struct memory result in leaking 2 bytes of kernel
stack memory over the network when MPTCP checksums are enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-net-next-m=
ptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org?part=3D2
