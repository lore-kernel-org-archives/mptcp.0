Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02D2038D5
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271515; cv=none; b=U5a/Z+AID5uDkV7F6zQsLDZvFD2M3KhunpxedF4aEuJt3yt6hkYHUlV7+wisksn2d9DdSCreM0E4Nf39Q7ADCGv12TqkVu0mkBghx9ftt6BRvoWw7c2yADJ3cTd2nEiBZ5YhLdFjpjk0I75gGr/MGMGQ4aKv/a1+C1/3IYXeEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271515; c=relaxed/simple;
	bh=XOWlVHmwveVsIP4zEcy5QsRZo3y+GrLJG7mIOCGcCw8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=k6dn4J4OXwXdJgY2vqFPz4UbHsvqFHr8lJFvfNd5HhuMx4Ha8v3V1rrmUVH5l3TWzJ170/zMwrlnpNqrJhUman2FLHdAgeSQVyAjQlepH9AAKkB0oEPUEZsDAtAWezm9l6Fd2OFtvqwqrgAgSPoi+DUVCwoqa3WJ8JWgkNBuuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PThD9ada; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PThD9ada"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e297cc4b134so2376141276.2
        for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729271513; x=1729876313; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu8t9zOmHXaIfEx6/RCe5L4q16hWviKU8DYDQpeWsr8=;
        b=PThD9adauFgYP7/jLIsl1MurS0tOxZB3N3GG0vlx6nOZEBnip4uooAriEtOfss8pph
         RGnTGFz29PFF74Q4UIdE1S6Qmi8QrCTZhFXWreyEZjWNn5tMxkS9cXQA/TDM1eihVcFK
         /5x2jSucwPj7G0EJxPvlJ1buGrVvVkwkVYZEMi+3OHdPnrECsypCAMcVH/NyMv4djXSz
         NMhQZ0hNrOXFlQ20/TzZfvP/qWTjIV4Tjvj1FT5sYWCu27ZOskhv/+/Z4xLD9Fd8R7u3
         Eh4Py/TROwc+OFNiqds8vof26GKxgW8+Kg6ka0XNiKAUrnb/EoX6IF1583GLZFlf6hOA
         VmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271513; x=1729876313;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bu8t9zOmHXaIfEx6/RCe5L4q16hWviKU8DYDQpeWsr8=;
        b=Zp0sQoVgPUN0YzklPrpEMxY8iW7CoyI2KXoqDQsTqzK54cjNYCuH6BXQSBNPI7gfMi
         hxar0Tuc2meZ7JtyU6ayCLedCV9EHjU/F14Op9G/Z2VmMKk6bk1Bvkchh8jf1iXkVF3U
         sla31HX09FxSWz965ibCkdaddu0jIEnrU5RKsb2IMqzyKxgOQVViXbyJsBgPjBySRCCK
         gP9VoxIY6SS8oQPAVZfatXjnJem8mPOzbkXAMekpVAnL9nF5InbbAXA6b8TaccmS6G2I
         dc7RNKCNRAsV2hD41xSG1CjwY8aGaiwfrG0cTlegbz5ZB1L+gtTWVSxE40XDUshxRGrH
         1Dwg==
X-Gm-Message-State: AOJu0Yx7Uxi773M/EHPPE0fyj3tJrPFCYaPB5sJHoh8Ya8r7eAd4UKtj
	VgRiD1Zj0sCxB6mQs0xQlQ/533G7dfDR3gyqqey3LHXYHrvwUW4U6d8x
X-Google-Smtp-Source: AGHT+IG6j4C4baBTr677w0OEgTsLytV2tDRCJZ3/qQhoSHLrS+Rld7i1/HDvOVpxbmOJIil9O91WJQ==
X-Received: by 2002:a05:6902:230f:b0:e29:782f:3161 with SMTP id 3f1490d57ef6-e2bb12f6a34mr2966699276.17.1729271512659;
        Fri, 18 Oct 2024 10:11:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.242])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb03bf4casm379571276.48.2024.10.18.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:11:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729267039.git.tanggeliang@kylinos.cn>
References: <cover.1729267039.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v12 0/8] add mptcp_subflow bpf_iter
Message-ID: <21e3a641-a238-eb21-edd2-ea6825047a3c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Oct 2024 17:11:51 +0000
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
uns/11407291080

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a649b4b1bfca
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D900798


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
