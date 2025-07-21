Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB2219A6B
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142011; cv=none; b=lBKIZibeq09JqBFPJdw1dh//1pxm/ty46Xd4odSmcKNxBLRu0hYjLADO26RjUJDg4POYZK8AGUUIqfRjSDhO+l1PS0diSMzbGWfQRyjWK/YMeCzdVxK0jLKManeOdGJU2U+sPEOvdosVn+DSBiyAHYYDM/THGQvuaY/YeO7L7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142011; c=relaxed/simple;
	bh=rT9WKuGpSHbi0NqeKjRmAaThBheJ+EHWS5swMndw1Mo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tpCiVm6LRBci8kV5GmjkXsL3HNl3hck9+HHZnWXuQPued5drzReAjixZa7P0+Nmzs13IFtMzHcMFw+hTdSLHg4FA+v+cYNaRHE43Iif8gp5TU541o2yDXbipw+yNBvH3XPab3zrM0DXTDH9BgNhpIxsHPe8kBQfIZQ9jHU0CSj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFJ1Cehr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFJ1Cehr"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e182e4171bso524792285a.3
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 16:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753142009; x=1753746809; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX6nGGuxWCRBZsHW+KXTLHjuVBv0zMAyWYIl+kif+Gc=;
        b=JFJ1Cehr8eJYD77BoKYp/sMtomaJq4kHB8StIye90CNHP9P7AUHCF4CTNAtCLBjpU9
         wOjkWXE3sgsateQSMpGdFZDXUe8t0FlyAsBUZYdAew2Hw9OD3GQD1BUiuGJsX0zHx6r2
         cM+bt6rgRahiLjltD2MQlwkMg75CSr6T/3uKVEzkb9hFk6/IwNS2UYdz4Eh9V/aqN//T
         QCfExS3oshwNlJSfz8sCVmlVGGxy8FW4V4MSTfiKP3PEET7SLQMq6C5hSWx9WxQWTNdV
         CFdhHgNYXCeKzlidDlB0hrovjorhudMiIuwcHj6StcDvPu41P7jERkEqIgKex0dgDFUO
         F9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753142009; x=1753746809;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CX6nGGuxWCRBZsHW+KXTLHjuVBv0zMAyWYIl+kif+Gc=;
        b=h1PeZTiQwMC+WPGbTDKFnS50M5dzef2U7cu6CVX6qXYoA1/bJmVmHtO+8aTY1SQNtl
         +De7HGO/anKjpOI1ppr4ZzAaYY+ZzoKrK5IeLoRFOrwT0RY1e7nUJ9P6jangyYi19Zvm
         46EuJSNHaXwUOPc+jFcdo4zPb4Z8TTdlmpmDOrlNsYJKyedIyafkDNHxLEM3KgQHUEyd
         dQTFm16mAaxa74s+paQ8/o+4buurEjXEkGqbPQ8kCqNL/ah5+C9iL/e8qAGYHzZUpS1p
         tJE3SYUoUQe3blQxmwEWTtngHQCwGYh5vhOy+askvT1FH6bbtXD7lRbDV0p1an4zDdPN
         mTGw==
X-Gm-Message-State: AOJu0YzzdGhWGFbzmWcGRAOWb6eqM6E+7LvujpaueaC3B7DJ+p6Gx7Sx
	AGYVDxtypDNPYWviDrDSd/12AkscKkL4Ziw57o2lYnTEMEhyM33DrTA=
X-Gm-Gg: ASbGncuzE4F0CB2Naj6MElRSHdPHipPOE9p1CEUy51Rnv/1AjZvHZOAWiu2VOrYaQkH
	D773k08fiYOQyqq/Or7xGyAx7chCnjR5FVZ06FyYW6KqoRS2dLjdlIVD+QPb1U9yd7yiY8tHKvk
	L2e1oNnmHBdjCkq1YauG9Cr9ZXoD9mhjLPvk6nROfp2zz5w7ec9bfuUWbiwEZN6/lfuOR1VciJd
	g0WCIB0D30ydRQanKHc/n6fRzQhWEoQjGO5XxqZYT1QabmGl3fGrct/5DIeWIYYxK9YtX9OvijH
	0Da6zsd2FjicPRUEQ3FmNUBjTRx/kRTW06R27INIV665S0UWqYLadAamnLfZlwTZb4PKoJXmsc8
	TbAFoKGlwDoP6VNC97LvI7k+zv/UkcSyXjk9vTzYR8gnLmLM=
X-Google-Smtp-Source: AGHT+IH/9S2oHrAbNWReDw3t/WT3xGKgGGN6fWtka04TNHfaxsz4kLXqqIqGIoZ8oj3cO9s/r1zJeg==
X-Received: by 2002:a05:620a:4443:b0:7e3:3cbc:786d with SMTP id af79cd13be357-7e3435eb6ecmr3069521685a.28.1753142009067;
        Mon, 21 Jul 2025 16:53:29 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e35b7ea37bsm439528185a.79.2025.07.21.16.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:53:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
References: <20250721203624.3807041-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 00/13] net-memcg: Allow decoupling memcg
 from sk->sk_prot->memory_allocated.
Message-ID: <03145815-5c5f-1ad7-1c06-b4810505f0dd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Jul 2025 23:53:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 2 failed test(s): packetdrill_sockopts selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/164279=
54278

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2b90b2bcf308
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D984458


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
