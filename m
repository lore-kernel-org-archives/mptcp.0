Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5852AF0D
	for <mptcp@lists.linux.dev>; Tue, 13 Aug 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564513; cv=none; b=mPTHetWu/X6L9sxUz2xLlQQzJskeSWZphvKIGu8zEHU4Xc9QgoLW+kTV3vsIRZC1+2QEeMNXacvhZCXmFcVri1OQRKtX816A3GV56U06alRmQ6f08ka5gqQx9+mZBtKCeQF0P+AkQmrU2GHHMl7BIzAz5SFXLj5/djlK0UBLKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564513; c=relaxed/simple;
	bh=2MjaYJ7S4DG4dvkhpcEZWsHgxvP2UU3CAv5hp0O7bU8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=q5C9EUy1D6VQF1jVWHXGwrI2WiEjfeymC9DHH42V4gtaV+U5UvEqDaFbMaAw8iHrYL8Koo3KP9dBzwg412fIWy5sKdfbnp9gNm5OdeotHqZsNOEp1dqyVECGYJfdmHbPzLTl4LwV2gq3y98Gsb6kzKUNFvW+ea+w9d0WEu/CEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnBSAywa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnBSAywa"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc56fd4de1so40585ad.0
        for <mptcp@lists.linux.dev>; Tue, 13 Aug 2024 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564511; x=1724169311; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd1hbwaCwIzywA3TlRUWk/zl1EPhLZ6RIqnVM0HU4IM=;
        b=XnBSAywa/G/ZeN4v/SmLeN9t9d7rJ+gq8eBJXTaSoboaeozXKVF1aV8LVaXvloMA2w
         nAfPf+I+7XYYWrdxJ5+9EB0irCr5/kXtd7AO09PaEw8gnT8uW9LjTJia1x0yVQvURvSS
         csRtDxWKRmZTMsu+GbL8ymeEsS35QO5YY5R5EQGFwrrLkuMuX5UQMzT/3GNLMt46XO/Y
         HnBUzuafk+xpy9Zgd5bmL2vyhcWuBTBhjO/WhkLdrSkgp33GTtsGenChdcYZfOf0WY70
         jFd/W+5kQ9Ju3bbIImekVI/jSQZdalV/xL6rGbIMuk+NizMlkk2/pQ8+zNK9XEaQ8I/R
         2Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564511; x=1724169311;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hd1hbwaCwIzywA3TlRUWk/zl1EPhLZ6RIqnVM0HU4IM=;
        b=Y/tB0WbisiEHdEjSZouNGbzBz66Tm+fh89Xc3cejxdgVi8oAs5DUL85Z1BbsLtfmtP
         tIRzS8PiQQvFv28aHJHVlUwgB6PVF0JI6QZgXMvR3Z+Cxbb1WfqGoC2/toaPmtxwnlWQ
         aDiiNaevX5KMqVhcjhESSQvB6jUd8cgrKaYTyA9GZMtYN3XfxAafff3Ta2v8N8tY5nrS
         vqnJNMQo2q2U1sFP21k05dllVcJ2EbiI7zz/wWS/n0CrHKPeBRGpn3VQUl/7mH68voLj
         2/b66UdCnD1WI4nFJ87vOgXnKZuS2UGdrK4qQQKFL2OuQ7G0spZuTrIrjkyeTQpjql1r
         wXbQ==
X-Gm-Message-State: AOJu0YzYW6trRB5oYpbURQ9IJkzPHNOUym3EWXKwSu4gIU40xW/5aQrs
	KZ7uMx9znIsesG/BtIHLm8T1DFgp6p1+vO7pLuJlzG7oWO6iJEg=
X-Google-Smtp-Source: AGHT+IHYMWG7TL2W+PTXNRFrdQxtP9PcRFlMlrM5r6VmenaLW4AwWTr5O1FCUpURGI19PeiCpEoqHw==
X-Received: by 2002:a17:902:f54b:b0:1f9:e2c0:d962 with SMTP id d9443c01a7336-201cbca31f2mr44654275ad.31.1723564511212;
        Tue, 13 Aug 2024 08:55:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.24.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1bce12sm15243425ad.227.2024.08.13.08.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:55:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240813-mptcp-sched-retrans-bkp-v1-1-78914a88c2c6@kernel.org>
References: <20240813-mptcp-sched-retrans-bkp-v1-1-78914a88c2c6@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: sched: check both backup in retrans
Message-ID: <c97809cd-80be-4d7a-64f9-a7772ac43010@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Aug 2024 15:55:09 +0000
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
uns/10369004703

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6ac41d97714a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D879179


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
