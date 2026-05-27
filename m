Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAEE2D9EED
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860241; cv=pass; b=RNPLGUB5a3ZFu+IUGTxNO5YWJy7vDDn7WcTVjJL5WkMExZ8DpiUSE7CjMAgBne5uB/mApSHNvSfm50lNdilVoD4NF1ziqpaqeGNDbqZk8hC6BrYtTXZ/SapvXhVzroQEpUBsEI7Gizldp2xKmvEGOBAPk9y4sWb6lirjhLcL7cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860241; c=relaxed/simple;
	bh=vU18o49wrei0SoXtGfXXNYBLFtfjUTCJVAdzmpRj8dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwnbTeEInmAxawars95lJrzfSedi0yIADI7zIqMjWt5DWTL18ZbjyLuzQKXO0Qcd8zMTxLWmYZZKB72SQvDytVBCrXZHOl6O6wa4AhOg8NvbRqNav9PbHkCVfpggFPdzFSw80ELqJF3unpoBz74P/SiBTS5SG5AGxNt1zT5uFFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9kspeXe; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9kspeXe"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-485621336easo1736372b6e.2
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 22:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779860239; cv=none;
        d=google.com; s=arc-20240605;
        b=lU4OxbtbI5WMT98SFdmNRLr7Xp5xm8lYT0wDKMMPs8P3L4zhHDwYutkq0js7qgMayD
         eJiwgOJHOmgw32O8/cD6BzYTDXskhRQFddfxQgqkIGIX04Ki8u/dWHDrGb2Wziw171he
         d7kbjz+0IDKKuonQ6Ayn5pM2raq81rzXdoQwfEdv9eOPZLJNl7bUeFd59AevdVjmPxN4
         j6dKjfC5hB2E1GNzsrIkkN50G25ToduNfIH5np8V5cXESAlgtn7VcORQutkWKnNZyjwV
         jZpe3qWBCRqgr45e3M8W6dJ0p9bg4Y1R9ROTGkpwDD4ntec3HxxxsrletXeAGHT2UQFl
         yHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vU18o49wrei0SoXtGfXXNYBLFtfjUTCJVAdzmpRj8dM=;
        fh=uOgxwBv/G00xChfAXgYBX18fjEAiKqASTCSINK036KA=;
        b=U7091WQyiqEMxuxAy7StfhU51BZue2CK/ML8NcfolMLaQQIOwiejuQdxtVe1k3htYj
         d/dpzcJUiRokuJL9Dd+d4uF1DobzqQPowPEtCpuAqflk5KvFSNCmAglztrm0CplwQEe9
         u/V6kog1OaE62ZR3IpkHskqWVoqx42wnSJnjxtoeCLsm0YQb+fb1KmqKkcOFtW7YHzKc
         coOBeA1CKcivuD/PMSVCU/iTli5jpyEiw0rHJohqvBaTqzI6bIObJrKkNhPCfqzUAEA/
         pa/Vi7A7x65c9nybn2gyhPsDoaulcCB8GVPp70mUWwt9EeQgb4VBKNvIzheFBId2nNV9
         n1TQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779860239; x=1780465039; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU18o49wrei0SoXtGfXXNYBLFtfjUTCJVAdzmpRj8dM=;
        b=D9kspeXeKolcREmyqiI7WWGcTE+H0AAbauHJZr18mryFM0gdtcartYKcqy0ZGc4rKf
         jLjLypSak/Vt7mhhHShi/vYFV1KHP//eYDFcyuoUq244mB0J0ci6O3bjIawlk13nCK44
         uiEjWReVyy+Q2Iz4KLe41daTR4nfMqYUGA5xpQVZEXkr9jR4war23wlQJD3ME/He6/gF
         z2X1YslmX6AjMTGchEpLEk1SmV6VCbz4p435HFcocFPX55JgqV1xlqb9xF2lQFvaOBVO
         t8gBNDpwC3kABVjIM/W+zbTVskl0kizyUJja17M+j4e0dxaVGYECUm0uZ2UmrvqQC7KB
         LVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779860239; x=1780465039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vU18o49wrei0SoXtGfXXNYBLFtfjUTCJVAdzmpRj8dM=;
        b=UAH4nsZSP3D5bTCiQ66lXRnHrvpcVaYHu/6tzE5tN4SjIS2fc58CSgSw6GesiKUbXl
         vmWKJZJWSasoiUq4sqBWM71UDIDApv6GwOuglRq4vdGG+ZgBznaw2EGkn2NViXYrAJ3V
         b29NLsSQrm38ScNIL+MqbRQYhkgpQipkBcdrAMfT1agvjZ6qcJz1oHXrnMsLhgnq95+d
         ktwlU8JnFbnFZLLMSytKiFor5KxutjUfYdpqI87Tv1EI1W0mSHGI07dJlj0b1bpnZseO
         Tv23sTUrLCXY8SdtdgMWNkKEUbSHJG/Omn+LFKtrNwgo/VT9rLER1AX9BXfBNcP77Y4K
         O3jg==
X-Gm-Message-State: AOJu0YxhQdytnWr8gjaV55slQ/j03amNN3sQoNheK1p2gSKWp8h62+1v
	VfF5zmeEGEGHVvp62vSznCFHzfdgIv3D7bYMoCZgy9M0yYRyQ1hzavPRumTm22eNP8mxM6Xjr7M
	ZMF1JwhN3BSl1FlNHD6Xh4XDoqsYdZOE=
X-Gm-Gg: Acq92OGTMuhQRn6BXO2ov8DyE81JrJ4zbotuIweLblRd9eo3RRVjH/1OXrZ7BUKV2wq
	i8R46ZczM6brjFIP7RpHgKAEOI+CDdADmlyKRKcftXX/je3YE50b4uxtYYN8iltD4fjAS1olAtJ
	zHmUZ53wwaFizj+IU8I/0ZKRkrv61fhKLu4nifrCiRIFhqaGuglyC0iHMIi5OM+QhvTr0Dg08VY
	fNBSXZTQHiO0V7dYZiqtcMhcHteit8XahNOsd2tNv7Aibt8ImEsIOCbxqaN7X5LVFzR9+HrRgyh
	NKWDaNZiJCQwAqhl1cVq1H/jrlNJrEDSX2CjwvF67FNl6eA0
X-Received: by 2002:a05:6808:4f6b:b0:479:eb19:6e6a with SMTP id
 5614622812f47-4854a1eb099mr13421365b6e.34.1779860238705; Tue, 26 May 2026
 22:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260509211651.104934-1-devnexen@gmail.com> <361aa4ec-f4de-41f9-b87e-520c65b4a2e1@kernel.org>
In-Reply-To: <361aa4ec-f4de-41f9-b87e-520c65b4a2e1@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 27 May 2026 06:37:07 +0100
X-Gm-Features: AVHnY4LP3dYauAGsmdgRaqO2hTgFj6suivTUJ3cr3dDslSr0iR9cWpFLRPfmkcY
Message-ID: <CA+XhMqy15PFeQuknC_ywpbvCooz4Y67MX_WB2RVw8rY1pjQaaQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v7 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 27 May 2026 at 06:08, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 10/05/2026 07:16, David Carlier wrote:
> > This series adds MSG_ERRQUEUE support on the MPTCP parent socket, so
> > poll() and recvmsg(MSG_ERRQUEUE) observe TX timestamps and MSG_ZEROCOPY
> > completion notifications through the standard inet ABI. IP_RECVERR /
> > IPV6_RECVERR (and their RFC4884 variants) are propagated to existing
> > and future subflows.
> >
> > Patch 1 factors per-flag inet_assign_bit() calls in
> > sync_socket_options() into a mask-driven loop so future propagated
> > flags only need to extend MPTCP_INET_FLAGS_MASK.
> >
> > Patch 2 wires up RECVERR setsockopt/getsockopt: snapshot the value,
> > apply it on the parent, and forward to every subflow under lock_sock()
> > so concurrent setsockopt callers cannot leave parent and subflows
> > desynchronized. Newly-joining subflows pick up the four RECVERR bits
> > through sync_socket_options().
> >
> > Patch 3 splices forwardable err skbs (TIMESTAMPING / ZEROCOPY / LOCAL)
> > from each subflow's error queue onto the parent's, so pollers see
> > EPOLLERR and recvmsg(MSG_ERRQUEUE) on the parent drains them. Subflow
> > ICMP errors are dropped =E2=80=94 they will be carried by a future
> > MPTCP_RECERR channel.
>
> Sorry for the delay: I saw Sashiko had some comments [1], and because I
> noticed you checked it before, I thought you were going to send a reply
> or a new version, and I forgot to ask here. So here it is: is the review
> correct?
>
> [1]
> https://sashiko.dev/#/patchset/20260509211651.104934-1-devnexen@gmail.com
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

Yes, both findings are real.

For v8 I'll drop the skb on splice failure (matches sock_queue_err_skb()'s
own behaviour under rmem pressure: -ENOMEM + sk_drops++, the skb is freed
by the caller). With nothing retained on subflow err queues,
mptcp_subflow_errqueue_pending() can go from mptcp_poll() =E2=80=94 which f=
ixes
the lockless conn_list walk too =E2=80=94 and the recvmsg retry in
mptcp_recv_error() goes with it.

Cheers
