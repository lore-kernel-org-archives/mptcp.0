Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B42F34
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402453; cv=none; b=DIdSIApSSQsCD22G3Tlj9MZXBIXkg+RiGQv2yUSP5ojd2s1H1wkpug8n9tVEy/NK9iX6siDsyp3UFzSqHNqjdZ0ikn7vmrcqdWivcowjsjJZKorQ5/ULxhGI3sWSm5iKcSJUzjCkfFq4O8gWwyXLdjKT27cX4BbQeF7AXlFSXJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402453; c=relaxed/simple;
	bh=EViRu6KJwbqbAE5QwM1evTP/DfrVCI/KMNHXc0tOQz0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bjekQ0jX+wa7LVkEuxXM94SwCO6LNUXu9ImmSQbj/a3jFcoLgSPJTqFFk2ECszoIRDpqNrNE9JAU8wqwgO6G8+wzih+leqAD39n1M5HhPJAOy2JY2DKqGY9/rw/XIzeYqdbEIXTFTLw4O0YODAedd0aJGTZkXuHOfe7IiVXBhPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXnfanzC; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXnfanzC"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b7acf213a3so4104206d6.1
        for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721402451; x=1722007251; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1HeM+qAafFSmmwPmaVTQByf+DMcY5/OqMannpJWETw=;
        b=IXnfanzC1p1sY1n+Y1My2VJEk+m3PLl2i6CDoot5olESh01Sfc+kZqMxJ5adFvLYAf
         CpkuedN3B2pB7gmN9Do4vMv8rSxeIgdKE+IOv8iLVUwXb4AqxTW6o3BbgifwDY+6tu3N
         R4DbxM5LHEjSPDErI+b8e2hlVSpQl0gLu6zboPcqcpYXAIWwhx/hfk5lxboZLrJ7JT3S
         To5ophE6NDc7Twy2mtyWkTZeaTu2Wb+rlxXB7261aAOC0ywWEEODK1AUbvAN6QpPPjUs
         Ga1TxJ+iqTm6TbYW7dos+Q6hEje26kZ5K7aKCEl8SFYVwVl+Bk9O813Ipw5UN7xuQyMK
         iv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721402451; x=1722007251;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z1HeM+qAafFSmmwPmaVTQByf+DMcY5/OqMannpJWETw=;
        b=wtOFlhAVJ/loDsqzFycrDUppgEQASs+FHZ6b3Pw8dx5IBPHK75QDFKZJimlVUl4FGI
         Yl8jBJVqHXFWseGmpO/USoB9KMSs2XoqFpT1x0NnpIjQ0N3wY1fZ7A9N0T4IKY5U8ycU
         tlY5sFDywWIhHylonwmWf5r0IYKy639G5ms5wtYmZfyAbrgc3L6RjBHcx+dF/r8Jjzy2
         siGZpsV+vOlKQcIDZYuHKnly/SGr1mhAF6DNN6NvvMcfaDkUdrI6cKTkYInzTzfMAAyt
         8tSGvY30Rhy1iWCAwIdsBKmZ5UHcaWTLcveBeqeJrxf8vi8bj7nyxh2ox0as+UeKi1ml
         fOQQ==
X-Gm-Message-State: AOJu0YwZxi0PP2s//sma7SttRomSc2AmGTMlVf7w/V81rqKxcj/SIchS
	wbWhZpNt1ISuO8IXUDUVPzvQivXwql4EZFCUaI9YknaUt+hPr/E=
X-Google-Smtp-Source: AGHT+IEGO5i5QRlfYa8D4jkWOUhoasFmWcXLdswdZu3jo5GFJJUDhFC2qrgHR7yxaIqm8YemLOlOYQ==
X-Received: by 2002:a05:6214:d02:b0:6b5:e451:81d0 with SMTP id 6a1803df08f44-6b78c9f96b2mr98771186d6.3.1721402450981;
        Fri, 19 Jul 2024 08:20:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acb07568sm8370926d6.133.2024.07.19.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:20:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240719-mptcp-pm-refact-connect-v1-1-1027d648a65f@kernel.org>
References: <20240719-mptcp-pm-refact-connect-v1-1-1027d648a65f@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: pm: reduce entries iterations on
 connect
Message-ID: <7e487491-d576-1d74-4d66-f73831b47586@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jul 2024 15:20:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10009902599

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/21b17b90d368
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D872563


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
