Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5019DF9A
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844546; cv=none; b=l+5RAZAQz5gWUsFGH1K7mQMPpZLCeWs7pHd8xxS9Sty8iP7fe2tZVNFEmFnKgyMJRdsTyuxokrJbviINi9zSfLYqss0aB3P/lIdTszgyRQlfJ8JslfEFYnEiHtqZS/JA9ErEl07jqYJURShi8xTw1AkKKDPspxsYQZyw+9ZlVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844546; c=relaxed/simple;
	bh=Xv8JOu2eVRDwT/6zmlVLqRUu18oEA1awvVuf3O23y3k=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZVOBU/Xtro4pvlTeJJ5gbPmRooCV+KpEOibIas83VGdJbXEUjhXosLvr3VAiNzOFhBbnJ6Tm5s4Ma3uAH6WxnBdpUAKMc7+0NosOGvjNpKdsluo4pJ74ULIlqwVqePYoPt6cPHiqE+4TtDeOBhtn3emEOk4Hvc9IgqBZyWwysKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyIjX2Vb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyIjX2Vb"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bdce2ee10so2832382b3a.2
        for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754844544; x=1755449344; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds5jNSoYNOHtTPAkheLmy8+s6x7gMuS78UGzHJYgmQU=;
        b=JyIjX2VbgIIvqnLHkBdoHGUC/bIq7YHOB67EXwPW2OBYbpc3B2lX3ya+UV6HbArRY6
         6IwFCieJjDVA0JWXv6ErEeG0zKfrS1mc3TLyYdZbCzYb1uMMPYkbCfi8Yof7Fdn73fmG
         fXCV8UMFAr8GYoGfWcYbrvkVMF1LAkV/mwzvvgxr2laBL78AKbCqzR7L6dZm4c9u4k/+
         2Mds9mwB/tUZWtkMPFgu14jdQM31FzTlzlQv5hZOFEiM0LeNOl8frNUvMU+XBRVl38pR
         xgqOxRm7BlekD3I4LR6XeuVLe72jCz+ZTC8derbcTSjGDWCQYHfS1PvkbENwf19pfu8W
         lIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754844544; x=1755449344;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ds5jNSoYNOHtTPAkheLmy8+s6x7gMuS78UGzHJYgmQU=;
        b=cNsqaUaoPoqs+IxvZkRu002MaGu7/4/OyIAnNyMF0AHznSwwOiWKHrzEETSOSJWobW
         kVfTEZhsK0NDWct49sWdR6fns3U2W1DsEEnVjYIYCf7EuGUqtk8M2W5FB+rPxgvqfaBn
         kXkrgvrSOuvyUI1gZKoCyVxlZ4QvDIPPmbT6O8fqIgFHcxSxDoU73u4G7ilVQD2n5CVi
         RZIBhoYBSUPnExNZiRo8j3SGjGSddvfox7ECsaXhXWJQMYOJlksyPE24tOPMKN8mnmdu
         M1V5gb/4YLnX9okcTeC/oPYUh1Ehhu77Vt3zIntfFk9n8yGWHKxPF8yCoVq6wDUnoawL
         LrlA==
X-Gm-Message-State: AOJu0YwuOauHL5kVNi2Yxp6J3qvx+kfjdqS0U+5KggMiujQEbZCXgv+d
	4QSSjYdLvLmiRaNUITEf5rfM4FZbqcIatC1eW5Y16jekwZSU4DKNvnCFZf2d
X-Gm-Gg: ASbGncsVIv2wl4+CV+PUPX0UoTlY513K8PQD7vhdWoAg97Xj2wGYXa5BSQSUMpnIIw5
	hn+2tUJltiVNAkc+TQRr53f3Y/FZ4hKuyki2ALPCyK8X5vHsUPE6wlizVFMnw08ANdhSWeU8oRg
	aZndt1B0Cc8yxITFh32nOh085399V5yqazyrYHWxr+lZvhO1RpmxcDUA5V5HZ1jGRl/YcPZJDsD
	zZdsDy1IAs+cpNe2H7qy9n8LW15txPextQLpA0y5DsuG+8xdNWiTY8lwRvv4Ly7vAVdyBqjlATA
	RohI1y+SrffV3NwIqTxaR7Chg0qR4NJ5NNe/W/dqrdOSR/21f9Pl11kfAEoJnWHLzPqbJQIc6Po
	IfvBaITqjFswKyNT3z1T0bM/Xbk9k81Qk/g2nkyllx4TL6Idc
X-Google-Smtp-Source: AGHT+IHRnIKPJEsD7hnX0HDgs8a4iIl3uUQVitYA3zS34Kq7pvsdu0AjomDrVIbP8+5sQoIyW0f81g==
X-Received: by 2002:a17:902:dccd:b0:242:b4db:3b69 with SMTP id d9443c01a7336-242c2243175mr105844775ad.39.1754844543914;
        Sun, 10 Aug 2025 09:49:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.175.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaaf05sm253277735ad.162.2025.08.10.09.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 09:49:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <8bd99f42654b94d0a5f1ef22d3ed7cb077f50368.1754837876.git.tanggeliang@kylinos.cn>
References:
 <8bd99f42654b94d0a5f1ef22d3ed7cb077f50368.1754837876.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_sockopt=3A_set_?=
 =?UTF-8?Q?TCP=5FINQ_on_accepted_sockets=22?=
Message-ID: <97f43716-331d-9ff1-9ca5-b4cb9d520eeb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Aug 2025 16:49:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16863231062

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ee2d54a34de0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D989715


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
