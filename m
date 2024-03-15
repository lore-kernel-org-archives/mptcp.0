Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604F1B960
	for <mptcp@lists.linux.dev>; Fri, 15 Mar 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502738; cv=none; b=PbmjgMbEvv9FvdEzdAJpczhYM/jcRX3vx/8lFwb1H0jFUJSbqxBu5S8nP/u9WLhgCVd9RY/YyRoMysYWow2kqqgitwyRRFFt+Hw+il/bcRrOGBazMKJX5K6SqYYtHZ7GzI1Dnz9RBlyBmmLibfqH0+attqfuO65wkM3BjuzIJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502738; c=relaxed/simple;
	bh=RfgMDmjM1TBHXtbtOyR3dcnCTawKTqDestn+GcItY00=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=drhjAI6smrgJP1G+b5xtmvNEkZQjWMj4/u/DOSeR4ne+Yi8wIYnISWb/dpOydmRrDWkdxSyXgnwcfY6FW3WC6eImygDj5SJ03g7pfpzU1IdUyZqYq61CWuAN6o5OLq4XAxtltflhDn3fSa1EJqNjg/wPnJN9m0zBbpc8+/cPdUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJuwkxKn; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJuwkxKn"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690b8788b12so12263856d6.2
        for <mptcp@lists.linux.dev>; Fri, 15 Mar 2024 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710502736; x=1711107536; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u2r+lL/dNChGG/YtoK7NN6gxjL9rqcoTu6jU/hS9IA=;
        b=SJuwkxKnSLVrbTrf5yOnqbiorldWp1p7cLw1SW7qume5mGhAQ0AozqKktxIou9PgYE
         sx7AQn5vHi9o9zNZWLH1jLwfQN7sdMabY8Qr07uOh3TznZViuNWvZsa+UnLnfhJdw+pc
         a9flWYdPcDIxZSRTdk0y7Pvzv1dYE17pg4F/CMgxLM3KXoGWbVQDRsKbHuVvnfIZyqGZ
         cmG7IiY32qF5aOy3NxN/1jWOdGnjQMILiJXWc11P6RwLjWnR39xBk1MMRLM64+9u93Cw
         22gPwtVPjxTTeQJXA/Dkp0vw5qgWeIXBo+tDEUEZyecbIS+E/Uy9J8yxYkq2TfHjFPjn
         +a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502736; x=1711107536;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8u2r+lL/dNChGG/YtoK7NN6gxjL9rqcoTu6jU/hS9IA=;
        b=mEVDQ9wkg00D4wMgV+2hbbQ8rjznmkLNxvefBSHTWS7fv7Yxi0oAkRhzEepgCuGYW+
         6HQkpOCzqw4a8wyY8KP6iuT5INGtjOK2ivjLVmYi0H3Z/dvbto7Dn7jCt5VvT/N0A1T2
         0b0olr/MWbArlWdIBOyeqFUJKW8NeAMWldQJxbotIvxg8JjvVICiPHVPnK/rRmSIzSBF
         MZmYWfUfDJP5ipsioV3muuizqP5reb+YgrxmXG5Ilp2oEJRHhiUKlkOgnoHU7eO3N8VT
         5sq5IdJlspI0PG0d1SRQCOVNDwyFzc1I4mFs6L50b1Y9kcMz29ChmqOYsoZVFY3N4YET
         88og==
X-Gm-Message-State: AOJu0YyjS3Zrl+0S6Mr9g+4kWXcrkvepUBN8Tyfnu8p7GqzoZ0cZnQC+
	2L4YYiASQk+YptMJ4bcANDsp8z3nhbB1/MBHZ26tdbM7zDbzUoqDAOGuBTBCTQ==
X-Google-Smtp-Source: AGHT+IHAI23EHJD3iJ83lOumdjz2HDw3ZGzbQZxmxV7Ge6BAWz6MY/qJ5xgy7USEHk1x6QXBtrP40g==
X-Received: by 2002:a0c:e342:0:b0:690:c49c:5d27 with SMTP id a2-20020a0ce342000000b00690c49c5d27mr3202240qvm.4.1710502736161;
        Fri, 15 Mar 2024 04:38:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.98.195])
        by smtp.gmail.com with ESMTPSA id kd26-20020a056214401a00b0069035d9a576sm1844114qvb.60.2024.03.15.04.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:38:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c2b0609aa21bef01ea1191dec3c127612cff3ebc.1710499440.git.tanggeliang@kylinos.cn>
References:
 <c2b0609aa21bef01ea1191dec3c127612cff3ebc.1710499440.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: join: fix dev in
 check_endpoint
Message-ID: <c28f1935-61bf-553a-975d-1f4e4a974af6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Mar 2024 11:38:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8295194678

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3e73a387af82
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D835571


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
