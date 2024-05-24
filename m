Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AC184F
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523288; cv=none; b=YEDhYscAZLIBGjum+iCQ6Z/jRYRQ15SgNjN10MeNezbSqALhRM5IgrKfS3HTsBkASkYaKLS0vjixa5Bc5IbanNlV8h1nCuSXMLU6u1PiTBtnogqXrUDuuaWK8TUBFhajCM9VeLg27XMcnVc1mdNTDgbtzyauiIfT1niNiVoxMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523288; c=relaxed/simple;
	bh=LphgsRgb/ZSh1PqZs2HKlT1uAg2RB0yngxqydzfHqdY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Vbxec39ID9vV6+2NoOhjaQ2KwzfJv2pepV1N+cRhxRUokykN36KIRz7i+Zg2HjNJKz/As0PZPYUNqmEK8rkoqwJjH5jcnu+0GxxeoQXpW2vw870C6DVK4wvzy3Dha6eJPrL5vEswA4oaXUUimrmBB0ogjRnwifVM1aL1f1mtj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw5qOFEL; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw5qOFEL"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792b8d989e8so190803785a.0
        for <mptcp@lists.linux.dev>; Thu, 23 May 2024 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716523285; x=1717128085; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJKnnx5KPR+lf9hYoZ9D5WsybLBZlPOZq0V1TO+W6Tk=;
        b=lw5qOFELIHt7tuLoy5BmW3IinGd9wB+wNyuySSKy53SXeibYmEmcTqs6lCeXnRW4EZ
         CALaA6FwKJUkQQUi2TqO28LIPhWE3MR5sA5jpQtH13UQO/YkjD1BDID1tvf3Tst5Ol4r
         idUUhQF3I7sWpTYHI5z4RKqdniOOm2RlMq4otm1pVVfK6e4gn6ZlWJOO9Afs2ivTX7k1
         oBAfvcJDwzpG4lpPnGGG+brFuUbuS7hsQDxRc7XNHl/Rn1S9xvTiRTvXpyI/12GqWgr0
         yJjexU2LcMxLtg0JksaV2jn0iv0iCWXsFa4zJHLdUBX8ba4/P9Rs+ULMFHauxRcd49rj
         vv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716523285; x=1717128085;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJKnnx5KPR+lf9hYoZ9D5WsybLBZlPOZq0V1TO+W6Tk=;
        b=nIEcBO2Tr3y+AXKS/jEi8+6gRvhXM1J1itfseNQVF9o23LEMFUpS/fXkF6iI+zbPoK
         67gfmW8SH0lYYWL1/mNbZwhOuTkZ6f0q9HmZLrLRxfMLAAwZjXa8bleUCdElB2jUVLU5
         tbsaj3HU7nuJDTPJYZEnlB4WUTHiyPZjcSZl6+TT6Jmbe0Ekq6ve91l1v46sEpArns1J
         goq3wLu6qVF1ZXw76B2543u/z3Syn7Lnw9WfOI7a9u4EAryZnlu0uOS0AipbpTGwlO8l
         8MiyFwHoB77zO48znLTM3WTQyG+/PIqTFlEQLyEw1Q1uGyae5sEEV4ZBrk943i4TjQ8b
         NS+Q==
X-Gm-Message-State: AOJu0Yw8aFJhyGHTSrILe3oXiz5vSl0rgy82nuFcHgMLK5wB9B7fsUrS
	+nb4/nIYKODeN3Y1lieNLPkdiZC9P71oy3Vb8NdQCjsX7Xf7V0sw3KB0
X-Google-Smtp-Source: AGHT+IHsugiWnQH+brvZgzUqMi6KQD0rJ9q7RT0JBBxEAWa8fZtBtQbJm3Hz7exvdCAvkgoT7SEBqA==
X-Received: by 2002:a05:620a:270b:b0:790:c15b:e192 with SMTP id af79cd13be357-794a0a2d290mr776836385a.32.1716523285498;
        Thu, 23 May 2024 21:01:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.14.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcdc746sm28169385a.70.2024.05.23.21.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 21:01:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1716519897.git.tanggeliang@kylinos.cn>
References: <cover.1716519897.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/4] use helpers in lib.sh and
 net_helpers.sh
Message-ID: <71562e5c-e093-6962-a245-b9acea80740f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2024 04:01:24 +0000
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
uns/9218177603

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3f489d2ea6c4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D855553


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
