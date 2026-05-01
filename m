Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50873C1963
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777649338; cv=pass; b=JpkN2ncapqrKuPsm1wEwsB7aFxg7X/npsv/CF7rMf3ffQnq+0O2wbdkhEYxgBEy9lP/heZzYiQAAZikuYBMsyCbwgenfVrpRViLIFz+YitXO2zdEinBCtJeRDSbpczcYYMGT5O/utCsGh8H6atPzWuxm7akjbmCrArfJrH/9n1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777649338; c=relaxed/simple;
	bh=Ap3OAMcD8x3T4o1y3h8t9juLVbLeZ1qfKfU4UgGLQ98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VazPnYaK5uWMJcdMyWf+ZQPBnStRtCqqLAz2mCmO0QbqIGNZbxvaYJt0XG4wb4EVtODwDpeHviR2X9OEnkFB29D/jc9Yfhd5Qre0Maa8a4NTsRMrd1jni4D2Ntd73XPmravv6cNimLMrurRmkdl216vB7GoEsM0Vpd3v3/Sw2/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0RKnK1D; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0RKnK1D"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-404254ffe8aso1742500fac.0
        for <mptcp@lists.linux.dev>; Fri, 01 May 2026 08:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777649336; cv=none;
        d=google.com; s=arc-20240605;
        b=g9xz5hDEDTy1eQTYFojSpmHolVCeh7y/otesElKdgU7B2jpasConRhT9zD6mCzlM6E
         h+Xh0yWS26Dd7TVMRbFjy3DvQqb7U+/xf3A5l55v/rMQXSpxHjh305BdyznhKPSWh0Cd
         y/8+yw7Q2z00rzC+Iq1OXTQAcQ6d5NL1qGPiPHdfHwzvM19duZ4z+BdKdEjNQ1RZqesB
         JKFlc7bgxuk3jeT2uJMQ+XGaq9kbmDDRmqom2M+ZUoP04Lnkvb8Pf4OaRiIAzwm8HKzg
         vNpgOlsndaOvPlu6XVRoSQW3eZKsX+FihPZrR4afPOQP+b6et89D9qksrQZEVi/kCukj
         6ZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4Um4tKSYogQqdzSJc+T9BAf1zSt724yxxd0zqs758aI=;
        fh=3aq4rqqYDLX9E62ziLedLvZbHxOPygxBCZEI/Am5Y0o=;
        b=lNRbXRiyXgbRX5vx2wHwJCU4oXNfU5sSRGNhfrAln4CoaOvtIcI/eEtb8IVJFEZtYK
         YGIbDV3FuLpuHGY36d9hxx3RSvtXSfXGkWeg1P10bkXDcscPqassRipqiFixbK3TVdSN
         o8kZWpPPtb1VnNn1ddOVIWpUNVw0YA/qh4cl6BCBMzuomt7N0k2qzEOs12RA3sc5K3PH
         jvXhVJeDdDfaviEISIl2Qm5wQg4Z9ZKd+Rs2XZvmwic4allsytN8cUO2oYT8eIgCLjwi
         h3PeC/kWILwSELrqZc8YE3IgdjGT74G4ee78AS7FL6vnWJJs9Ji2bovi7UTKfrRHocUa
         BL0g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777649336; x=1778254136; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Um4tKSYogQqdzSJc+T9BAf1zSt724yxxd0zqs758aI=;
        b=Q0RKnK1DB388gzUsPjBXuQS4YAC0bcXDD7+ijpjhEKlGdbMWOOAiizNL/HEBxvuC/b
         hyAjjcliSv9hH7ePcljBnIFZZbBXb/uwnSo+1/cNixPFUE4Itb1/f+R9fbYGxV7IU/eJ
         mhoUuGeiRfn2DYUR87MZs7eX8Oi4zZhnvKAw95uUfpZjTmMQegiyPnDlCmZQ/ix+szrs
         J7hlcibgneIRbG5MmUP22CRrVzoAm49zf2og/sQxeccELjoJYJdemiUTNpYwz9blp8UI
         pyvlFaYcb68fsLXSuXu15NoOC5R6Ui9K2pNU17yP1ZO5tIvd+iCI9CQ3dobRQbccFJRr
         P/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777649336; x=1778254136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Um4tKSYogQqdzSJc+T9BAf1zSt724yxxd0zqs758aI=;
        b=AZJI4bxnQ9YKCMLhrGhWm1nojlLuCSWTQDji1jgdPPCKQKpSIi3ZCCFlUY98zP+gQW
         5RpuaBx2YmKrEFWYYY1TNBb1/x26J3gFaTwmf9e8BXW63lhFeCLbPtFBUK1yMxNbHps/
         +kcvx+21mBtZl3dsFcU9F1ISNRpVhTE/STmPhz2/i1QohyZ2syaGr4xyFLfBbYzRFi9+
         ZDlHDj5o1ozSrzLjlSLPndD3qybn+rilCe6E9yKChh8Hh57ljVLIiekSWp1xp9V3/vZr
         VBCUKynwd/WMqaTGTTMB0RQNmMtSgE6Lo0dM129niREPnyuvKo43e0OZ8r57Xlb61Atb
         2x/A==
X-Gm-Message-State: AOJu0YwBFh405lHoj/9cOd9dcDoBPoZ5plYnzF+mEDwmcHBhPU5OswPF
	2r/TXz+uJYctG5dgvRfaaSxfbu4Xz8jKsPjAaYuVgXziOgHcjxcHEx+o/hfIwZzb5IcaLChJNve
	BTtKNVumuT1pSHpFAzF95DS7BlazP2YM=
X-Gm-Gg: AeBDietRlnm9/n3g7dE3DLcIsuzQs1Y653CmXQFEBoObs1LWt5cm8Mwe4Bl6BDrsxKV
	LHHVoEBurzdP3T3pDOIa84MGzIo8bgk0407xEsgzXVk5L1OUtrY4jFyCMPMwy+bMewCvce3+Vqo
	xkyeTvl/UhSFppSgS+9ofPWL0wKv8Q/or+1ca46npqyI/l7hZho8I0FVLT086JLmiL/8oA44Eij
	x4W+8rpxnNvKiR1ko4Dg0IGC3dl6wzY8RDOd/8I36ygOmV7nImK5hbFCFE5X0oIvLcTgE80YhUy
	xHgQk4e7py7Ey4xU3U51Ak5CeoifiJOekeanEeLRe4E9OAJn
X-Received: by 2002:a05:6870:a10d:b0:434:81e:4a1a with SMTP id
 586e51a60fabf-43438b7a0dbmr3371469fac.17.1777649335558; Fri, 01 May 2026
 08:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260421223338.52743-1-devnexen@gmail.com> <cover.1777324037.git.devnexen@gmail.com>
 <43f69e5e-b0a5-4bc5-8e6b-8f41ef4cf55a@kernel.org> <59eccce4-cbc6-48b9-9243-9b9b5a5ca066@kernel.org>
 <efb7cbc4-a4c9-4f84-b440-0a2aa3267c02@kernel.org>
In-Reply-To: <efb7cbc4-a4c9-4f84-b440-0a2aa3267c02@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 1 May 2026 16:28:44 +0100
X-Gm-Features: AVHnY4IzS_fO6qBlXIhJcM9MJQlZqsawJmEPm3FS5J2WQGKASRrBf28nYF4hYUE
Message-ID: <CA+XhMqweRpN9-fjS19zx=a_Lm_XSsZsLB__xEzWyB4THsBOdiQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Matthieu,

  On 01/05/2026 16:49, Matthieu Baerts wrote:
  > It looks like the CI (and sashiko) found some issues with this series.

  For v5:

  - 1/4: per-bit inet_assign_bit() loop instead of WRITE_ONCE(), keeps
    atomicity.
  - 2/4: add missing sockopt_seq_inc(msk).
  - 2/4: skip family-mismatched subflows in the v4/v6 helpers.
  - 2/4: snapshot optval to a local int, pass KERNEL_SOCKPTR(&val) into
    the loop.
  - 3/4: pull-on-drain from mptcp_recv_error() so a parent-ENOMEM does
    not strand subflow skbs.

  Will also re-run the docker repro to check the selftest_mptcp_join /
  packetdrill rows are pre-existing.

  > But globally, I'm a bit puzzled: with MPTCP, there might be multiple
  > paths being used, and reporting errors about all of them when the
  > "legacy" RECVERR socket options are used will confuse the userspace
  > that doesn't (have to) know multiple subflows are being used.

  Fair, and Paolo raised it on v3. The use-case is tx timestamping and
  MSG_ZEROCOPY completions - both are tied to user data, not the
  subflow that carried it, so no subflow identity leaks into the cmsg.
  ICMP/ICMPv6 is the part that does. v5 will filter the splice by
  SO_EE_ORIGIN: forward TIMESTAMPING / ZEROCOPY / LOCAL, drop ICMP.

  > It might be easier to have a dedicated MPTCP_RECERR, and
eventually
  > propagate more MPTCP-specific messages. Something that could be
  > linked to:
  >   https://github.com/multipath-tcp/mptcp_net-next/issues/78

  Agreed - subflow ICMP and #78's lifecycle events belong there. As a
  follow-up once v5 lands.

  Cheers
