Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861A1BDAA0
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834368; cv=none; b=bmci4/pilchMrtMezjB3bfFhBY9YY4UfclEkXYQ7fmmC0VZSoB45BD1JBDAkshNJr2Fg8TLv1uCuPFRSzndPYYO822OZ2l13Oo/FnDWZGJtOAgni64U8lKmXdeDltG31zILCELXsxSUDRJqzxkqMIyPPmp+Q6DgVCR8/nYYRh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834368; c=relaxed/simple;
	bh=CpSERkS/7c0/6Z0ukgWbg3Md2a/aUyy5eksVa9QjBiY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cnfAAcGn7M4bSExb5VUTmUDdU9JhTxsFWKQIKCBYvf1s5ml1KyLTsXfEAWyTWLnyQq2GYGDIvnua969uoarP+eHJ8J0PHsdv+2UQaaneyms7TMumb6D61o/a+cWJ7HO7e7ZHoCARTIm3ayqvFhmbFUAMf8TZNunk7gH/ccbp7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZK6ISoV; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZK6ISoV"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d984ed52so150308085a.0
        for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723834366; x=1724439166; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY7RNTVcAOfxS+TUPva4ad/oga2QSeHIIU9vz+D9g9s=;
        b=hZK6ISoVyVSPa/MDjKEimWfxCGD9NwSbS3SZu7NTwN5scCd1cEA08O+LQuSbrpxjUr
         LHy2d+1M3hEqIDvR8Q0+h5afisL4u/cf8aGoLfKIsv569zxuqUS9y7+Jniuw8i1bNnDI
         8cxwgv/4D/Wgij+y/JrYsr1/yOFrzGeQoXjQ0FxOivDDA8tPgBqxh3ffLmqQbehFZcbA
         JutBczNmOgayucgQdI0mBWG+H/As0sZ7tECuwrNIfnHauZKkXyz342iRDDsk4r+4ndyK
         C9kA9SP3OpgI1nZe/ZEFLGPTGSVo1bib5X9VJHglzcdQgfHvAjJxAxgP1a3/OLHNoP7I
         vDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723834366; x=1724439166;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rY7RNTVcAOfxS+TUPva4ad/oga2QSeHIIU9vz+D9g9s=;
        b=ZSgk2pxiQcSXRt2qmWTK6QJYeNjVuzPQf9iejqNRzLm/bkkHDNaAwLOz/G3e2yhbr7
         TKRzMMvUa6MSZtSN6HW38kJTmV7Cqq4aSCQSwU1aO6Y8yPmB7TXuho1yEkFVoYV569se
         ScQMwz3pBxkpluIkIqW7n75q5RQFqcRYkjpMLkVXKp4RMO7PTCfvmUiexyFNO6OK5rue
         JJCkuLXGbn/CLh+SzUMlCBfk340eUFnU6eRlfMxiq1q+LpuIlKmTeYVbEpH8iCPPY9sn
         ojgYjRnaKABPEerRvpey76Dch9MV4p0MNjm/EaLiNBwfjoEsQtePGJl1aSvZhk5pS+Ub
         Oyzw==
X-Gm-Message-State: AOJu0YwlxhsBuvUiQUveWcbfMkon651VyVaEgX3i5nBNQBGp8lyk/ka9
	Qz7y7OlRNRp+civr2VeqOFtaDv0zFdVuVVYeR6iJ3pjFr9rcvuA=
X-Google-Smtp-Source: AGHT+IF1dRBb0A2M/EJXeb+HkKT29LHcGoN1fuYQGuMrZuLkdYK2xE2dITMgfOB1Eh1IwsXAyHXyPA==
X-Received: by 2002:a05:620a:2949:b0:795:5672:9298 with SMTP id af79cd13be357-7a506970548mr466191885a.41.1723834365955;
        Fri, 16 Aug 2024 11:52:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.51.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff06c53dsm203720085a.57.2024.08.16.11.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:52:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
References:
 <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
Subject: Re: [PATCH bpf-next 0/2] selftests: bpf: avoid duplicated UAPI
 headers
Message-ID: <f43ddb1b-f30d-8073-c3c1-9566f9d9d668@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2024 18:52:44 +0000
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
uns/10424338865

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dbae3469e712
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D880440


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
