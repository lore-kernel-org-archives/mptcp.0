Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E16215F59
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050920; cv=none; b=HXNukqRDnUUtCs/gF3ee0vw0q92GIF+qQ+zdazSw/vzKZIU2PJsE+E3803Co9LLlgHfOJoCB1/LFBS5EapirR2hgeXp8M0hcrkm4a0+TmYoIXabMynmLyxIQVn1LONTswA+TbA1DcnJGlC3ucHEbWnV00HQ0Nd4QTWYiTD+/7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050920; c=relaxed/simple;
	bh=wOaEotLoIoUv/jxuYrySyxlkkuj2rNbHlxSrDlBKIV4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FYGPQ9dJKIUHwc/Al7PY+rz+8xE2EnxFexabbFt9CPmPkIW1bwRdNEPTZEjwXgCQag745dwpW3jxduWnXv+JfkOgAAfl0i31aQD3hkRQTbtU7VdjGwML0OHPI/eIil9l/uZXkmXQ4XPhPy8FLo/dLZ37pppE81ba2j+SWtMw8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amGJe82U; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amGJe82U"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99fd0535bso168442185a.3
        for <mptcp@lists.linux.dev>; Fri, 04 Oct 2024 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728050917; x=1728655717; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UojmtarP9SS5uCY3s0wGT/r6L8ReiZVUyqdnbUEK7bg=;
        b=amGJe82U1E/RUB5HdaOWXqiW5V6KN697YD5AYjRv4ZyxYdfvUSGQWFXUDYvPBVfmtu
         60GkzAXN/Yyet39Y/3WCfc5q1VyziUS4XUTNMjM/etsXrvWl4PsihnDMKmOHhJXpSxZJ
         GqI8AKjXUSuBRVxVarTH/i11Z8LGBi4RPlWP50aCLBkBHzdmePzBVyra9ur+WrgkvdP7
         +l9U4w/apFEIyDREJZNEwNtAuiZX4etozPLdQiX33X0wZ5X35c/L+9r8IMgtdBV5KDJn
         7jeHohxe7CFKBDN07/0dWO0WiXL9OOVprB6/DSd0kfV2j3hVs/tj1/aYZZxpfMpJZzKP
         L0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050917; x=1728655717;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UojmtarP9SS5uCY3s0wGT/r6L8ReiZVUyqdnbUEK7bg=;
        b=gbY4Ne2rrT1Y/riBs+jsm+3HO5hzeiJB0dfBxPvsvvvnRuUqJaphgydWztVaqUx3zy
         BENnoGBT78bzqZtBbXMSJtGplUfG7dD5oCUoCEWPyGusudTDhjVfxEivcoOtIE6NED+L
         dQoWQy4UcDi8NBhMeNFH0UdBYDTFcOuWQYAa0g5FnL7cVKhmw6sJS1NvQ0HKcaAvdGYb
         h+IgaLdcOluirZMBVkiuGXvT9r3QvkQXTbw0paYWxRewx10zYcpDHLU2nP5PP8DIT0mc
         TgWyzAvld2hW/saG+pCGnCv/x/SIk/F4RYjbAdsOcozsoJ5HpQ4prvv58TyghtoYikmC
         IjOA==
X-Gm-Message-State: AOJu0YxcOLr1vm5XitAO+oWtJotWm7Hk9mcUCS3FbZAxCy9og/wFj5QL
	WsH8rNOvr43burGAtjKIYJxdm9ZooSK0KzTJ9NLx/Obi+syOeZ5Mm/mb
X-Google-Smtp-Source: AGHT+IHGbyVUX04deRFvdcuf5EWRPUl2h6VHeJHVhzcpNDBq0mOUwAkzE6RafVz7vCSQRPQiNzuroQ==
X-Received: by 2002:a05:620a:29d2:b0:7a9:bf31:dbc7 with SMTP id af79cd13be357-7ae6f493a39mr441706085a.53.1728050916953;
        Fri, 04 Oct 2024 07:08:36 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.113.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3dadb2sm140196185a.114.2024.10.04.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:08:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728046021.git.tanggeliang@kylinos.cn>
References: <cover.1728046021.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 0/7] add mptcp_subflow bpf_iter
Message-ID: <6e28aaf6-8c5a-10a8-f0dc-17947600c8b1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Oct 2024 14:08:35 +0000
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
uns/11180592738

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b8cf8908f57e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D895563


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
