Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323C3BFAF7
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449930; cv=pass; b=mhXdkausj6nZg9n01FVsdmOhhjByqBUDKGQ0MCq9UiKccThzTbSpH+y34Sr11as9rZuU/+4B5UuUK4aO7W5fEAwa7MtzRVTTapXvqRWmlAfgdXh01fGnmGNah0d9810tCb02O6g2LEoI1EVPZlOXixT6h912tTSPo5Pjs3TZ1j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449930; c=relaxed/simple;
	bh=iGhry8OSy5NpUf/OudCWP+OhrPgRkmkd2lyoQM640zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvJiIzj2QbXi011zX+BrKGqDRIuZi2/0Y8s09JGgzoixc5RuYUhrl3ayqrjDw/SxM5u8VnPM+paQ7c4WZPhMLgAJuHbjrzI3pDbBRDr5mv9DH2FFpzo05FZxGKtCsDD3PcNhzUzsEEVc+aPFqemoMZGAAkR8lQsgf7rSd4wyCAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E04bmQq0; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E04bmQq0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535853983f0so9765741cf.2
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 01:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791449928; cv=none;
        d=google.com; s=arc-20260327;
        b=nWJiKT1dX6kKkPHOQIaoX+rRvnGFkqRao5JzkMk5kXJdFMpdOdyaAN85avvNFw7Vz4
         1fn6khezv3mCmXLvCWTWbq69ozdZYzxAiEBmR7YT8d6VbR4xu6+ENCAnysRKhuaVSa5x
         dhx3kO/AhpOvPIjv+GznrNX4HCaRRALmAh27eAAKX3baPUWZM30uxtjmAopQIR86bI0b
         cT4HTbDeQ2z7Da3mJSmU2r+V7MV75M62yMLYcqnU/VHLXj/UhRXM8wOsLFIHEWOY7TVA
         3x/c+pP+Wz1X409crLdnctJPAAU8fs6RqDHsSZ+lP/cb6Wp55+A+lRFpIZNI2l67TmDK
         /L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f6WGTpJs/XXXD3HACG4yE9wcBHyQvNNrKktD1oYCass=;
        fh=ADFV6cWqTCV4Np/Z8BmLQMQCk4WAoyA/VCm7DLkMric=;
        b=EroZqPK1hphPu3b81+3xko0vTuV6djkn3o8khkp6XZyPwSQHchvxyShzMVvWZOe0ig
         N/+ALJVZ4f2V7JwiU1xEKBSBcZrBcsVZE8jfW4Qgryqql1tP2G0rrYqVezu8giGdlMy9
         YYNyOic+IXMc1hou/pg3+EL3URPNs/svxilsRvGDBbhKzr4lxJgXL/r5zV+EvfHftyZT
         y9lL6vMdUnWrqn4gB0W+GIVG58xZZ5txh1gE762m3qpvGiTOpsyW76sSSGE09X1Atwhs
         xc5CThzrwYvgsWGrj2ozxdjy5BB1xITIxT4xPO97/YTsLZY+u8/8QP1UQpqAOxN1dA2y
         JEqA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791449928; x=1792054728; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f6WGTpJs/XXXD3HACG4yE9wcBHyQvNNrKktD1oYCass=;
        b=E04bmQq0r5B1ux68D3hqlpiT0bai4DnYFzqmS9B+xEdcLJ4IRl4UYs62jY60ScPEuq
         1xm211H2MJUVKPKAcKt3mty3cQVGXJKMtatrYA5rZqBcm012g1U8z1s5Bru4SAUHsXKU
         u21kHVXksphkRfCRAy6YO5fUPFH6ApDwRLP1EzQm9cW2mcO0eZ1HDODDhJVQ7Da93N94
         wxYR5X8QlYEHW+PGf4LsZlGJnskO9Mq4Pl9ko5Tp3nmj2/FYuTme+TkGAGicKpLztwd9
         ouPHy3ccTZfOVG3UFC+gEN3qJ4rYHKMl5ApPbMhj4MAg5Ir/lR5GpLLPxJq9F+SsmjOt
         /aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791449928; x=1792054728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f6WGTpJs/XXXD3HACG4yE9wcBHyQvNNrKktD1oYCass=;
        b=2aH38LZK1B9sbSNiUJ2N2gNKOtEl0cGkJzXxEtX53AuIaTh5vMk84dLDatJJH/yssu
         Yi1TvF1bjg4Myv9Srv9u5h5J20U9T74xI5nOZG5CAWf4dQEs8uIPcQp4q99GPj5mGcRD
         UPDBpP5CztpxaYOxtNM1yBmTxJG9awRI3jyY2xIBdz+O5Sead7NjG45ffJgFtwNOvDFm
         mnrBUr+u5X1f2peH+AOyaG+2k5vDwvqIyu+nt0VMH3h5YJZbkgISNvDMwo3+bUVp1p5/
         lV45bXs1ApDbUUSjqNWM3e8uZqfTLmfIA8PbW4eUTTPUPNU8YkeiUuGYUDWYSRG29uOm
         tl2g==
X-Forwarded-Encrypted: i=1; AKwUvBxKBydrEXFA4jbq4xbNMdrimL82RcWeOS19/fDp+Y23S0TGANXDPObvr01oZ3JJE6rOekvgtg==@lists.linux.dev
X-Gm-Message-State: AFuF++na6UfquRMzyTvRKyDAMID7KN/IlbSLG0jhy+etHugErdTv+ZGH
	6EEXC3IqgdMzWD/eNAh7bu1aVpMGqqgGQ5pgRcOG4/lAkD4AuFeXcdqwtnOwp5uaioaxQ2cgS3a
	09GoZkik82ideVKBg9+t6FkMW9b274e8=
X-Gm-Gg: AYBFou3PvD60p9X7RMrqKHBFOIuXH5tbcVYPlV2h/sFAT6mFydG3vqMrFGmQi9Wp0SX
	hiZQUWwqBU+LJ7cgw9sZRdUs06Oi59P5cM3a/z1KoeT4vmVbAJUGnw2BAs/OKNTl6JgmILN753I
	ljt/Oq6dVT9YIrJnWsd1s/v1usOryRLJI+Qd/GK8VDPedbWx5qft12glNrlivL6PmZFAhvH7osF
	ltQHdYUDD30PETk6VTng6TfbPCT8BuSrgMIJJRPxmOiHAzJQ2b0q9mjKPo5sCHrYJHG1vKXQBRM
	3gimmQ3SrgJ1wZmQiVGs30BDdFg0ey0OGHRQOdn9VFAgcgjCncvseteV
X-Received: by 2002:a05:622a:309:b0:535:198f:9cb3 with SMTP id
 d75a77b69052e-53575571eeamr93171101cf.29.1791449927990; Thu, 08 Oct 2026
 01:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1788800732.git.caoruide123@gmail.com> <f66560e3-b821-4e70-980b-d3a6252a022d@kernel.org>
In-Reply-To: <f66560e3-b821-4e70-980b-d3a6252a022d@kernel.org>
From: Ruide Cao <caoruide123@gmail.com>
Date: Thu, 8 Oct 2026 16:58:37 +0800
X-Gm-Features: AclHuK_2TFbmDoxBsmcfKlZVfWVsNVYNJp20EISwQYaGbvpGPwk0ZZDKLioHjuE
Message-ID: <CACveakRhBR6RiGMO8Ur0V_N1SfNk3__h6g+EbkcYu=9kdBGYsg@mail.gmail.com>
Subject: Re: [PATCH net v6 0/2] mptcp: fix request migration ownership
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	geliang@kernel.org, martineau@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com, 
	kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

Thank you for taking care of this. I've opened the packetdrill PR:

https://github.com/multipath-tcp/packetdrill/pull/207

Thanks,
Ruide

Matthieu Baerts <matttbe@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=89 02:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Ren, Ruide,
>
> On 08/09/2026 18:41, Ren Wei wrote:
> > TCP request migration clones pending requests with inet_reqsk_clone(). =
Some
> > MPTCP request fields carry ownership which cannot be duplicated by a pl=
ain
> > byte copy.
> >
> > For MP_JOIN requests, subflow_req->msk holds a socket reference. The cl=
one
> > inherits the pointer without acquiring its own reference, so the origin=
al
> > and cloned requests can drop the same reference. Patch 1 lets the clone=
d
> > request acquire a reference while verifying that the original request s=
till
> > owns the same msk.
> >
> > For MP_CAPABLE requests, token_node belongs to the original request and=
 is
> > hashed in the token table. Copying the node gives the clone invalid has=
h
> > state. Patch 2 moves token ownership under the bucket lock and makes to=
ken
> > acceptance and destruction tolerate an already moved token.
>
> Thank you for your patience. It looks like we were waiting for Clashiko
> report, but it didn't get processed for some unknown reason, sorry about
> that.
>
> The patches look good to me, I suggest taking them in the MPTCP tree,
> and I will send them later on.
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> (...)
>
> > // poc for MP_JOIN:
>
> Thank you for the PoCs using packetdrill! Do you mind creating a PR to
> add them in the MPTCP fork, please:
>
>   https://github.com/multipath-tcp/packetdrill/
>
> (if it is an issue, please tell me, I can add them later)
>
> >
> > // Minimal reproducer for a stale subflow_req->msk after reqsk migratio=
n.
> > --tolerance_usecs=3D200000
>
> Usually, 100000 is used. Do you need more?
>
> > --non_fatal=3Dpacket
>
> Why do you need this?
> > `sysctl -q net.mptcp.enabled=3D1
>
> This one is not needed, you can use '../common/defaults.sh' instead.
>
> > sysctl -q net.ipv4.tcp_migrate_req=3D1
> > sysctl -q net.ipv4.tcp_synack_retries=3D1`
> >
> > // Listener A and the owning MPTCP connection.
> > +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     bind(3, ..., ...) =3D 0
> > +0     listen(3, 8) =3D 0
> >
> > +0.0   <  addr[caddr0] > addr[saddr0]  S   0:0(0)         win 65535  <m=
ss 1460, sackOK, TS val 1000 ecr 0,    nop, wscale 8, mpcapable v1 flags[fl=
ag_h] nokey>
>
> (When validating the listener side, you can drop the TCP TS options,
> except if you do need them, clearer with less options)
>
> > +0.0   >                               S.  0:0(0)  ack 1             <m=
ss 1460, sackOK, TS val 1000 ecr 1000, nop, wscale 8, mpcapable v1 flags[fl=
ag_h] key[skey]>
> > +0.1   <                                .  1:1(0)  ack 1  win 256    <n=
op, nop, TS val 1000 ecr 1000, mpcapable v1 flags[flag_h] key[ckey=3D2, ske=
y]>
> > +0     accept(3, ..., ...) =3D 4
> >
> > // Make the MPTCP socket fully established so it accepts MP_JOIN.
> > +0.1   <                               P.  1:3(2)  ack 1  win 256    <n=
op, nop, TS val 1001 ecr 1000, mpcapable v1 flags[flag_h] key[skey, ckey] m=
pcdatalen 2, nop, nop>
> > +0.0   >                                .  1:1(0)  ack 3             <n=
op, nop, TS val 1001 ecr 1001, dss dack8=3D3 dll=3D0 nocs>
> >
> > // Leave exactly one MP_JOIN request half-open.
> > +0.1   <  addr[caddr1] > addr[saddr0]  S   0:0(0)         win 65535  <m=
ss 1460, sackOK, TS val 2000 ecr 0,    nop, wscale 8, mp_join_syn address_i=
d=3D1 token=3Dsha256_32(skey)>
> > +0.0   >                               S.  0:0(0)  ack 1             <m=
ss 1460, sackOK, TS val 2000 ecr 2000, nop, wscale 8, mp_join_syn_ack addre=
ss_id=3D0 sender_hmac=3Dauto>
> >
> > // Listener B joins the reuseport group, then A is closed. The next req=
uest
> > // timer clones and migrates the half-open MP_JOIN request to B.
> > +0.1   socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 5
> > +0     setsockopt(5, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(5, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     bind(5, ..., ...) =3D 0
> > +0     listen(5, 8) =3D 0
> > +0     close(3) =3D 0
> >
> > // Wait past the first SYN+ACK RTO, then release the owning MPTCP socke=
t.
> > +1.5   setsockopt(4, SOL_SOCKET, SO_LINGER, {onoff=3D1, linger=3D0}, 8)=
 =3D 0
> > +0     close(4) =3D 0
> >
> > // The migrated request expires on its next timer and its destructor us=
es msk.
> > +4.0   `true`
> >
> > ------------------------------
> > crash log of MP_JOIN> [  280.449259] [      C0] BUG: KASAN: slab-use-af=
ter-free in
> subflow_req_destructor (net/mptcp/subflow.c:45)
>
> If such calltrace is on public ML, please, next time, include this in
> the commit message instead (without the prefixes between []). I will
> amend it in the commit message.
>
> (...)
> > MP_CAPABLE packetdrill reproducer:
> >
> > // Reproducer for MP_CAPABLE request token ownership during TCP req mig=
ration.
> > //
> > // The first listener owns the request created by the MP_CAPABLE SYN.  =
A second
> > // SO_REUSEPORT listener is added only after that SYN, then the first l=
istener is
> > // closed.  The SYN+ACK retransmission timer migrates the request to th=
e second
> > // listener, and a later request timer destroys the migrated request.
> > //
> > // On a vulnerable kernel, inet_reqsk_clone() raw-copies token_node.  T=
he clone
> > // is not the token table owner, so destroying the migrated request tri=
ggers the
> > // MPTCP token ownership bug.
> > --tolerance_usecs=3D250000
> >
> > +0     `sysctl -q net.mptcp.enabled=3D1`
> > +0     `sysctl -q net.ipv4.tcp_migrate_req=3D1`
> > +0     `sysctl -q net.ipv4.tcp_synack_retries=3D2`
> > +0     `sysctl -q net.ipv4.tcp_timestamps=3D1`
> > +0     `sysctl -q kernel.panic_on_warn=3D0`
> > +0     `sysctl -q kernel.panic_on_oops=3D0`
> > +0     `ip tcp_metrics flush all >/dev/null 2>&1 || true`
> > +0     `tc qdisc replace dev tun0 root pfifo >/dev/null 2>&1 || true`
>
> You probably only require tcp_migrate_req=3D1 here, after
> ../common/defaults.sh.
>
> > +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     getsockopt(3, SOL_TCP, TCP_IS_MPTCP, [1], [4]) =3D 0
> > +0     bind(3, ..., ...) =3D 0
> > +0     listen(3, 1) =3D 0
> >
> > +0       <  S   0:0(0)         win 32792  <mss 1000, sackOK, nop, nop, =
nop, wscale 7, mpcapable v1 flags[flag_h] nokey>
> > +0       >  S.  0:0(0)  ack 1             <mss 1460, nop, nop, sackOK, =
nop, wscale 9, mpcapable v1 flags[flag_h] key[skey]>
>
> "wscale 9" is "strange". Note that you can launch tests with run_all.py,
> e.g.
>
>   # ./packetdrill/run_all.py -lv mptcp/<subdir>/<test>.pkt
>
> > +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 4
> > +0     setsockopt(4, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(4, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     getsockopt(4, SOL_TCP, TCP_IS_MPTCP, [1], [4]) =3D 0
> > +0     bind(4, ..., ...) =3D 0
> > +0     listen(4, 1) =3D 0
> >
> > +0     close(3) =3D 0
> >
> > // Let the retransmission timer migrate the request to fd 4 and let the=
 migrated
> > // request expire.  On vulnerable kernels its raw-copied token_node is =
not the
> > // token-table owner, so the request timer trips the token owner assert=
ion.
> > +8.0   `true`
>
> If you set `sysctl -q net.ipv4.tcp_synack_retries=3D0`, can you reduce
> this to 2 seconds instead of 8?
>
> > +0     close(4) =3D 0
> >
> > ------------------------------
> > decoded warning from MP_CAPABLE reproducer:
>
> Same here, I will add it in the commit messages.
>
> > [  314.661418] [      C2] ------------[ cut here ]------------
> > [  314.661636] [      C2] WARNING: net/mptcp/token.c:364 at mptcp_token=
_destroy_request+0x2b0/0x330, CPU#2: swapper/2/0
> > [  314.661931] [      C2] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tain=
ted 7.2.0-rc5-00353-gc27e36054537 #10 PREEMPT(full)
> > [  314.662092] [      C2] RIP: 0010:mptcp_token_destroy_request (build/=
../net/mptcp/token.c:364 (discriminator 1))
> > [  314.663001] [      C2] Call Trace:
> > [  314.663043] [      C2]  <IRQ>
> > [  314.663107] [      C2]  subflow_v4_req_destructor (build/../net/mptc=
p/subflow.c:694)
> > [  314.663213] [      C2]  __reqsk_free (build/../net/ipv4/inet_connect=
ion_sock.c:906)
> > [  314.663325] [      C2]  reqsk_timer_handler (build/../include/net/re=
quest_sock.h:137 build/../net/ipv4/inet_connection_sock.c:1147)
> > [  314.663762] [      C2]  call_timer_fn (build/../kernel/time/timer.c:=
1748)
> > [  314.668915] [      C2] ---[ end trace 0000000000000000 ]---
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
