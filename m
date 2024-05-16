Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E8182AF
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851869; cv=none; b=fMFmaLijUjWscJk1Rmd2CSBmyBv8InUUBHOcmPS+JJbEEremJzWGqLJtizZjmfHTTef9wS9idDHUgD8rpmKEOg+yx9MevZvPurJUkrxM9T8kgmx/hfGca99QEo+GjIYAnhlGH+fZTdNzSI62RuQSBjwIubMYR0dvpXETvbR1GBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851869; c=relaxed/simple;
	bh=G81ufRLvR/xSB9id8EgrCDXlMNbq6P7tV1K/FKuG79g=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=h2ScVBgaX5Jd2J5kxeDRkQpl7hf8pD3DbNsHycl7C0yPU3tizJI51UDP53tTxuP2zgpcTQ9WhmXUDmJo3v7803ZpveSGYKxp1nWP1mxpG287VYZZ0joy7HZP1BayizEbrbx0IXL2vRI3Fi4QKJFM+44ujWmIiEhsW8e00qkqA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deJQSCnK; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deJQSCnK"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6a0ce3e823fso41550576d6.1
        for <mptcp@lists.linux.dev>; Thu, 16 May 2024 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715851867; x=1716456667; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRJCH2MvVVjtDFLju88tsFf7buSF2Bi/GpzqZI2jE2s=;
        b=deJQSCnKz3awdI2P8PEPa+n+V2Q0O+vSe+R2YljjpFgKXWef+DUjc75lmlguIq4Ch0
         vjWn4V/w3/BDbgmEgTusC/aflxvSdpgkd8v62WzNrSp0aBb2/qEknbJvBkqfyNAYJXeH
         f6ww+lO8ejJnkXkgRfy28/9a3HBf+MAQyWdBtgdrr+lg4wrmt7PJC4tK3QlSM48gnnu3
         uI+qM0S4J8V45qeeM8I7JvYd2OlWHfUbJ/5lPg2gHTnz+QJqY2VyXZ/TcS3nzBR13OJl
         cg/A97CTNSQHJxP+ShQt+T01yHgereXEv/SUTEqTZaxD0smaMZYmvsHAFeRkYOWa//F+
         862Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715851867; x=1716456667;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jRJCH2MvVVjtDFLju88tsFf7buSF2Bi/GpzqZI2jE2s=;
        b=RNlXEoI2q+2B6pEozVjurtbgwCmAL7yooSTtR15KwLqP7anUZ3sC8+ZTDwtwa5gxzM
         TNWfJCM7FExiaJFv1HbJZlswA9rMbP9vewp93/18gUJTKJZwzMNSkpK/ZKZdO0X9PYCT
         rLeUFkI0J5JwToy9IoIkiEyES/9qWc/Vd31JmxHf7Ml7LUx4345wQFVYsP6qKLU8kX4s
         i6uYL1ZlCkRQ/DwG1W2BXFO4nnlfGR8t533C9JzZYXx5nxAb6Zk82IIN3f3qG/JbWKEX
         rNKlv75npo4/MCAdvPpd+a4iafHYwAslcpXmqfTnHT7VuMi+5Q0/6PkiCS+QK43qPjtx
         ZCnQ==
X-Gm-Message-State: AOJu0Yz73E3sV2V6TexdDi9kHdELxkj+OYBpBYACZCNjkFJ7pUhHvzfV
	XFn38zRFvO4DsWEc8bXPzL/K3f967sbux04PLm6QWElI4Y4THJnqVaunSTM=
X-Google-Smtp-Source: AGHT+IE1ItPORFB1gGPIikyQ1+DLk6O7MWlvpZoIEdIZGZzlTzl1v24owUXoKsWniQ8v+cpf93Se5g==
X-Received: by 2002:a05:6214:5407:b0:6a0:d404:e964 with SMTP id 6a1803df08f44-6a16837733bmr242449236d6.40.1715851867498;
        Thu, 16 May 2024 02:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.181.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d740fsm73393326d6.115.2024.05.16.02.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 02:31:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1715848543.git.tanggeliang@kylinos.cn>
References: <cover.1715848543.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/2] fixes for create_netns
Message-ID: <88c7104b-300b-5a82-ba9a-32970b9757ef@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 May 2024 09:31:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all):=
 Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/9109397952

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/448ec9f2f3=
c9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D853620


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
