Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6CB472096
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449964; cv=pass; b=iPCMmoIgj1mvd4QOzgnkmTcU8FucuYw8XdYbeXd0IS/Zen8VA9NxShqecMUjPiOt9P/SztcM+piHxHnxnlTTZn2TKZBkWcYuaPGgwCd8No3hlAjf0+XXlmhJse1zJn2mfSt7leEsj9XQspxiDYTOr98VCk807dKLPGjnELhavDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449964; c=relaxed/simple;
	bh=V9OfYkA6zuMtTZgZbtwdJbEfYN0Dn3ju4WLaCHbFiZY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iHosiJLi7Gn43MeaCZUARsnStTawLiz0MSjmrSltyRrnNyzHmkOqLAgdoRzm2rN1GgFpiuVZfJ6tbTtF1PKmJNbFF9ePvU8SF2IOiVfIGXhskQi4Vmb9aK04KXG954IEo6gKwO9pf+IT6NXpbqKBKPce7YuMZNBnXy06Xv+fv6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish; spf=pass smtp.mailfrom=ink.fish; dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b=n84/K31G; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ink.fish
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b="n84/K31G"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6aaebeadf3cso5007617a12.3
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 01:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791449961; cv=none;
        d=google.com; s=arc-20260327;
        b=EctP+ZSrqqYEzWL80rt/LIJtqVPXrmiAfWOHUoE66/LGasbh4lRFj2+f9f1jmOR4st
         yi2Uxix7Baw23tHpFo618WiT+fxqxV4DLXoetDWttD99ApTxid0BLTHsrcBKq27XN2IN
         5xEHDDkNsd0xuibOjgXj1lOCuAvLGEha+SSaT3AzPQ8twc39oH1rIak8G/qxyrg+AAMq
         GP8L0Ps3KpUSE/kRD1MfHUR9y36Lyr7iL3EZFWQh6l/es+wT+BCYZwkMUoaaYBcRqoj8
         pObIN/jgSbPM5EfFtYbqg24wrASVVXR5/sFqbF8ADg7f8++kE3wC73pHr2LIuJC8cQ+S
         +b+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mBhOLP3WmIJPpWiW67BdHkRrddxAcXRk0zqgY0VxRvw=;
        fh=VK62o09BttqJZljQPaJlpMv61+2+/Ks9CpwKP9eK/IE=;
        b=n84ktK25W7+WjsJ0UX5Y3J9WZQ422y7qNV20Eb3Fli5GiWpYj78rZn3g275vq31ZbQ
         2S+h1u1vrY5yeE8gGHOT0lNyb07oVdTp6cTgvIh+iyY4yvjHlbR5rzU+Z8EXidspAYzq
         gxxUxaGZBf4H69YKoTFDXYgWjUQ40L51QGZ4v953qfwrEou2NrauiAzGMT+yJN78d4XX
         kwEQPZjxky7rMyoeS82NDhG8R98OyQD8Fv5kt3gmXtl8xFML6ZGXWHfok/KbGFcW/UF9
         rhNm608rJkzesUTgY+/tWlnPnQ91x4zejjGvsS/8CrKaCT8sLitYpOEafCuUzhM26F47
         /55g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ink.fish; s=google; t=1791449961; x=1792054761; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mBhOLP3WmIJPpWiW67BdHkRrddxAcXRk0zqgY0VxRvw=;
        b=n84/K31GhEbEKUJLDV1cO1kh35rToe8M3UTmvkIZlPq5Mw1WUeLllK6+aaxabMmFrE
         HgtZRm8IlCTW96LkoRSqspFo224/EysOFTeEfbShP7+7E8OhG3zYK+CCFLRSr7ihJtoX
         CbVIcvKoztzaD/aSQFchKPwgV8nXHyBVj9upGlhUHQn5aNKfWLCfuOSUE9RWXIWyLm/p
         6QYqK+MKF3Esw/tJZ5r/soOqwtGWs54l0Yow/ZJ8aP+hgnGRNwe+kqbnRf9MhKvP4QyC
         fZg/h0uN5hfjM9tWgbyWO31D3syMyA77SCu/L/EiyEggrAGeR+dlEm16SiPs3jmXqiv9
         fF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791449961; x=1792054761;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mBhOLP3WmIJPpWiW67BdHkRrddxAcXRk0zqgY0VxRvw=;
        b=mp53DZjvWC6pJyc4Be1sCVy3mMDQzm/HVpDc9qixwmaEjNFpaLu+7lTcUJ+86aE1Du
         SJSBFfqMg618bGwpDpxPv2Wi+a/xFO2TtYWdgtT7KQNihr2NZir7Y1CcP5qN9YLUsKJt
         MkA0OhtZ4V6yiYFiW9QpS7IJlrF0brLMwsq+oUKxPYxMQ7vNKowiD5ftFMGxqObwl4+X
         Z/dcygk+gNP7X66C8xgTx8FcXb3St+e/aeTCCxn/n16BTzmOynV6/SjsHP8hrXZTNP53
         T/v9lduo+r3qjjoSN0k+Fg1wehmd9RDsqzzGkbc/kcYpNLIzYQMtQ1yoymnt6H1lQu1M
         G2uA==
X-Gm-Message-State: AFq9FYJ3UhJi/1TXR3/3NpY5ymX0z1Qr8nETnEm+uYRWsxFpmrxlLXLa
	oc3fj2Qtcc6LUdJcIQfFLsXjJxTi1DNvdB2b1rmzAat+dRKgkCT5v03fTNA+rWAkRM1sTAzsJ8N
	rMwce9KkaQ05ATc+T2l/EpVCuN4QWm1SyT/SBnfQcOeVFVtMTJ6ZVq0XU8/PJmHs=
X-Gm-Gg: AYBFou2F+JslRzM7vQ5Crsyc4+9KW3rQnSLnSqjWzllojN5UBbfJLRAXyTJOqZupcZE
	u/VMC6ToZRj5qIhnWOkh3sbnrK2kJ+TwjPghUlKeIIFy0tJlPpX+1vvyIobBIGFxLToIcQPnUJb
	wxDNU/kM6OSzC3urC+2J1HBkGsnGfSPEIgSNirFtLbW3tcN1k6o1LMzM68O4SQPnTfQyRp7IciO
	b+7dXArPSVfmhvgN4BeARE+BDwUGBj+VsP770jyfohHYdbyiS4uaEEWFVSU83dSxBN5CaLmNWBg
	5Or6oVIOQ32UHv42hv0oW0kKCI59nQaLI3gEHe08aYZOzekGzyc2fEBcPYbdIbx2wTL7Oyz3p9B
	GLwpKf6bA3ICAOzFELF5fjq+e55PD4kBxRxttKfDTpjiKoC4SVNXbNKqfpPyPNFsXlLyU5wVKlv
	Q=
X-Received: by 2002:a05:6402:90c:b0:6aa:665:830 with SMTP id
 4fb4d7f45d1cf-6aff39863c9mr4489257a12.15.1791449960726; Thu, 08 Oct 2026
 01:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Petar Sakic <petar.sakic@ink.fish>
Date: Thu, 8 Oct 2026 10:59:10 +0200
X-Gm-Features: AclHuK836IDATouq65jvcju88QK8M9m3jvnCMF6upJ-JVOeg7kgJFpniiqVMFf4
Message-ID: <CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com>
Subject: Bug report mptcp: passive TFO: data written by the server before the
 MPC third ACK is never sent
To: mptcp@lists.linux.dev
Cc: netdev@vger.kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi linux dev team,

There is bug I'd like to report:

Summary:
With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV (i.e. after
it has consumed the client's SYN data but before the client's
MP_CAPABLE third ACK arrives), that data stays in the msk write queue
and is never transmitted. The connection hangs until the client gives
up and closes. Plain TCP with TFO is not affected.

Reproduced on:
Server kernels 6.8, 6.12.111, 6.18.15 and 7.2.6 (Debian builds),
client 6.12. Source read at 7.3-rc6 (602042bf, 7 Oct 2026). Lab:
client, NAT hop and server in separate network namespaces, ~120 ms
RTT.

Steps:
1. Server: `net.ipv4.tcp_fastopen=3`, an MPTCP listener with
`TCP_FASTOPEN`, an application that reads the request and replies
immediately (we used a proxy whose upstream answers in < 1 ms).
2. Client: `net.ipv4.tcp_fastopen=3`, MPTCP socket with
`TCP_FASTOPEN_CONNECT`; prime the cookie with one connection.
3. Second connection: the request fits in the SYN. Server replies
before the client's third ACK arrives.

Expected: the reply is sent once the subflow is fully established.
Actual: server `ss -M` shows FIN-WAIT-1 with the reply bytes queued
and `bytes_sent` unchanged; the wire shows the reply leave only after
the client closes. If the server's reply comes later than one RTT
(slow upstream), everything works.

Analysis:
- `__mptcp_subflow_active()` / `__tcp_can_send()` skip a subflow that
is not yet established, so the server's early write is queued on the
msk.
- When the MPC third ACK arrives, `check_fully_established()`
(options.c) marks the subflow fully established but nothing pushes the
msk write queue. The third ACK carries no DSS, so no later event
triggers a push until the peer sends data, and the peer is waiting for
the reply.

Candidate fix: (tested only in the lab: 30/30 requests succeed with
TFO in use on a patched 6.12.111)
```diff
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1058,6 +1058,13 @@ set_fully_established:

  mptcp_data_lock((struct sock *)msk);
  __mptcp_subflow_fully_established(msk, subflow, mp_opt);
+ /* Passive TFO: the application may have written data while the
+ * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
+ * it then and nothing else spools the msk write queue when the
+ * MPC third ack (no DSS) arrives. Push it now.
+ */
+ if (subflow->is_mptfo)
+ __mptcp_check_push((struct sock *)msk, ssk);
  mptcp_data_unlock((struct sock *)msk);

 check_notify:
```

We are not kernel developers; the maintainers will know whether this
belongs here or in the fully-established path. Related but different:
e00b63056fb4 ("fastopen: only mark MPTFO subflows with SYN data", Aug
2026).

Impact we saw in production-like use
Shadowsocks-2022 proxies over MPTCP (xray) put the whole request in
the first write, so small requests ride the SYN; requests to targets
near the server hang. We have turned TFO off.

Thank you
Kind regards
-- 
Petar Sakic
ETO/AV-IT Engineer
Inkfish  |  www.ink.fish
Deeply curious
This e-mail is for the sole use of the intended recipient(s). It
contains information that may be confidential. If you believe that it
has been sent to you in error, please notify the sender immediately by
reply e-mail and destroy all copies of this message. Any disclosure,
copying, distribution, or use of this information by anyone other than
the intended recipient is prohibited.
