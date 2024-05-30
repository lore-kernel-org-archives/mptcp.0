Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF6186E32
	for <mptcp@lists.linux.dev>; Thu, 30 May 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077954; cv=none; b=U9RLZiDQcxcHx0oLrohHGI6C/vnOpGBgXjvvHssTF0nJVMw7o67kvLfuB/RduSEPkMq18p0CuwLyh+Au2ySUXu5kFtTPzU5JjhvRHw1ZqjeqXjTpAe7UrUSkdG5A5ebqnAvDXw2bISo4cV23C3AZWJBTAK3kXjSVwPmjzOGEKoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077954; c=relaxed/simple;
	bh=mmeZ9SFhJocfTAGRbIaBa9twi29IF8KcVx5hKmWBrt8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CU1Pgc3tBR5VHlfQEbfDNEbdzRB/D7fNx0qVRmK/CVC1h1iSPLcI62Ctz3+zGuHxsQG8y10ZIYnVA3LlTeI+uRyaWmaW07ecHXU7K/wAuO9b7+BarwyzPCOcyQfUJxM7k7BjwVEn5kUBOWEQ3l5qXrS7MgY+iNyEOki7+nyeNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUynH2zX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUynH2zX"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43de92e234dso7517001cf.1
        for <mptcp@lists.linux.dev>; Thu, 30 May 2024 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717077952; x=1717682752; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Min05YeNEBoWqSxSby+HP2e4ht+fFWhT0DHGf/uri+w=;
        b=NUynH2zXfVmSILC6ytt+Zr/jLowlrqWkG193FVFvZLm4ue3N4giDp9H4lj2mNogCcY
         QCEuPwQ53izm5/p/bxOWWKc46SpSLTS8VPP2APsNvB/DlKg8JfPXiX46dHVQwC1rNCdy
         J3Hbfn/Ua2NkC7mLuX9EzMhZPppo3rWOX+XGaqS1vFQPFHvoSrEK5SUClWS/xVWw2OdI
         lipJHogdQgDEY5XJwxs3553zq4tgb8J8mBU6i6dHbAKdZCBboA0KZ/JWMqVq0My9MMBl
         DfcbM5nEUpLnAFU1ng7/kmIo1cpjP4SNRueJTgx2YYB8zckIWZzXf4AgEZswuJ4VzSZE
         4Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717077952; x=1717682752;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Min05YeNEBoWqSxSby+HP2e4ht+fFWhT0DHGf/uri+w=;
        b=sfuq8ezD8l9yyHe1Su4p1K3dMR1C34gyUyGBVkZFCDe1RHat4j6bB7kC74lpreTKBL
         EbaG3kjC0JIDCyioNS4td5JD1KFiOM2bKPDyoNhXBoVfigUt4VWB8Y7tn2jjOGcpi/I8
         y2BB6E/Ps1QJoae9Tq+YmkNYPAtRiefVH3+0nN+B/CA3jBcOjhq7q8qgY7VXp7XPWwSi
         DG/MYiN0nAzAioNTtS7aXnVhOJ1VdWGJwo4mxQ7t1yi2fTQ+W+KTkO1y32wE70J/RWV5
         L9qSwM22MjIxxJ1N9YtfcY4x1MRmCLm4PGPG2etduT9LDksCEY3t8jgC7D9zL+yR293B
         fN0A==
X-Gm-Message-State: AOJu0YykXNbaluveGIyKmyadKJJe2nxIGiUeBSTZZdg+XTZEew8lD99v
	gKGSXTEApQb2DvWx5tO8LPpW73cO2hNps2qlRBUGDAV5KocOkUxbtC/T
X-Google-Smtp-Source: AGHT+IH2BlO6AIe07Zoys0k+yBYqOSReDBsx5OFKWmL18DnkisKVuGHyHoKjyBLNW6noKZ+/lFoc1w==
X-Received: by 2002:ac8:7f91:0:b0:43f:ec63:a5fd with SMTP id d75a77b69052e-43fec63ae41mr29780891cf.28.1717077950004;
        Thu, 30 May 2024 07:05:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.185.156.195])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fe7647f67sm12524031cf.43.2024.05.30.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:05:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240530131308.59737-1-kerneljasonxing@gmail.com>
References: <20240530131308.59737-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Message-ID: <8bbfc607-4275-c4c6-c663-75f03caf0f93@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 May 2024 14:05:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9303441254

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7f7bd9b64def
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D857361


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
