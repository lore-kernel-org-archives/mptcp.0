Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE221CC5D
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223492; cv=none; b=KGdrNvTwvfS0YUkx3SK/BzzC9IFUHT/FWmTKTpqnu7Y87eWco7q5oKW+fC7McK5G31MQEyH8QL49zmbo844P6zJ8/qzW2b7k3igvfNkjPvSFzh5JgwHT31iTs3yM9N8IcwQfApLPFoqegfU4ywuUex5C62Pnlt+ACVJeHpTE18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223492; c=relaxed/simple;
	bh=GOTSGEhTABcFlk9/Za4xjAJXmWessVGQ5U5pPgyISso=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PSQHrhepx6y3jgSdrvey4hIePCLAzgVZtPKNERH+r2IEa33Rs0vm1tZaHEwXgIC+ku9NjUlSKezI2x2w41R/ykradY9ZFmGQjwYWc/va8upP0/depAxgsyHQAviXWnn9rnuF3RZvf1MaMP+AbPuZdPrB3XFdAr9ZG9WzzUX9+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHQiaD/Z; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHQiaD/Z"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7de159778d4so47626585a.1
        for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752223490; x=1752828290; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH4bkgm6skyeKFVCc19mkLNa/aX7kw0pYLfAi/sL284=;
        b=fHQiaD/Zkcee7/GUgahJbxNaJ26K1ilVohZZYIr+YbLmAgng7g3bo7b9nrrwKc/hqT
         hklzawAf76nZgWNi5s6mhOhssWupOrRI/uORFlLoY4h2QuXAbcRgg9CKrb+qfLr7AdN2
         6OQKfNLIkNZ6wgo04fYiy34XM3Uu1mdHwc9FFYpDe6EI34KMMuZw/0fuwWkSRIW7YPMk
         2Vn78KBMMbImTsQQRoXAXB6Hk25tVAH5fGk7/M7Hzxh5CMqH1ywhP+luqVhoQ//E/Nn4
         cAQ0BAnn+qUor1qGlaeA0YeMg1XosjVjTerk69nGJtPmZ9J6upjL0L+LQnFITJz07OD1
         lD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752223490; x=1752828290;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kH4bkgm6skyeKFVCc19mkLNa/aX7kw0pYLfAi/sL284=;
        b=BrvyjT2vIFboqmeMmPQFKL8afzKQXV6xliVNODVC7KZLIb1SftqkCZWuvLH3I/iGH3
         DPZ8gos0b1Ts25DQiUb9628dgoazPbKHN9M5g31MXl5PUqkjb4aV1g7zxs7gzPmzJTdx
         VGvn4krp6bKpu2DiYhCXUOPXnkN2sV89l54oyrvViAiZuF7zFbzbpNzvT0OjEdn+rSSV
         uEOIti3X2rc4rHUCiyLeNDLVBrixCaSQNbajO34oTzspvXDPYrfgEzjjtEtd1X9dZd4y
         i/FjFPsCOX6PnwdoaZFX8t+eoEjrHWnYJiD/k5nXxeAeAe+cIME05Ja6JCbCeY35dngm
         S+mw==
X-Gm-Message-State: AOJu0YwJDsgh6+kRvGbLAI68a7u7SSCC+BUA68uBsHy5jxPqYz07u5a7
	/AQTBpYNwS8wvxPm5kxQUzh0HXvsVBuBwm4WrL+BhFsNGi4aPbyDx/7Pv6rObu4=
X-Gm-Gg: ASbGncvhYtUcdyex2KcPDlMbE2O7mJECnPVZGWbEFcgvNLYZMJC2zYhWp6/lypWYbFX
	jfU5DbTmltF5eboFDz2eu2yWCTIxiHq6xQaqibAw2kXyhWcryAu27lJq0xDrG5orHhijj1yI4Ti
	/1vjMp+Fu5piVbqqDq0tWAH+fTMlhBkqQtyxhZq7sPJ5u+vUVDKevQq8ZzKgxQeg2I4AUP8nup/
	34rny4laIia9FaNcs/UaX3f51OE7kTGMTkIxjukv0t/YzmAFNQm6wbXE9kInPwp6avj5mLcuwbv
	4c3uTWXxf92xFIWQ+PWgSAYqrqW4c+4Gh37j506fKbdDaXZRwWgDxAz5XLbeC8e/1BwGYNRNRI1
	/uxJiS6Y14xsP/N3gnqLkPz6zfwzMdi0IAqRqBQ==
X-Google-Smtp-Source: AGHT+IEejkPuQF//OlC6kXIimzimqvy+6OoNUjzbNi3ItiKZpCT5RfpeCAdzjLfcdMxKmFzUKa6vzw==
X-Received: by 2002:a05:620a:261a:b0:7d3:f1c9:174d with SMTP id af79cd13be357-7de04fb0df8mr342810585a.20.1752223489512;
        Fri, 11 Jul 2025 01:44:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.172.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497dd0be7sm17837436d6.114.2025.07.11.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:44:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752197546.git.tanggeliang@kylinos.cn>
References: <cover.1752197546.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v4_0/2=5D_Squa?=
 =?UTF-8?Q?sh_to_=22implement_mptcp_read=5Fsock=22_?= =?UTF-8?Q?v8?=
Message-ID: <1bb8db0f-2303-8403-b5ab-79e69b85aa24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Jul 2025 08:44:48 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16214201123

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/377a22ce925b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D981305


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
