Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773CE374
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978354; cv=none; b=CKPDwsfmWN0qPXqcSB1jgeoYGOOcWJ3bpDdKGikzxkX72QhKqrRyhRLzJcTJ59gb/q7X10Y0mfE85EHlcMV2ipJ/EJgI2t+/i00IIx06cg4MBwLjCzXCT4XSGOUyNVSBCMYcXNS3PSEas5IAs2BB/5Wab7Inu6TR9mD4qCKbzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978354; c=relaxed/simple;
	bh=1h780QO7fZnixgFzpCe8jX1A3vA3giDzzo4VJ8MqI+E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZAVkACu2QpKBxSIEBLd0CWPwVyN3a577gYTYvo0yXLNgYl84ALpBFy9vwUpMymJW7Q2LCF4O5bAco3fj2x6TuGxXNwV+tb2CjVzcEbwNCNHewCMXmf+10ljxcTUzUT6gfFUEZZ6imbEWhuPpUH2gTfApm2mWpt51n5NZOieq4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHmL+CfA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHmL+CfA"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a35982c09so15245091cf.1
        for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 18:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705978352; x=1706583152; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBawzcIsmutGApjzKJ2fwSLOeAdZ6Cj4Ps7r/9TWWyE=;
        b=gHmL+CfAw3kIUCavokDiSZK6PWZr415sUjQ2rtc/8aQ54kUtiE9fSqL29M65U6sUw4
         qJu38/8jyJ9i9TX10CKv6X87MvLBBXPkRyV7/Byt3TMFj3o0pPgMdZKQsYkJX8D9Nk7D
         rWOkQorksYpr8IXDIy+UWQO2BpCZKGTFDvR3Xc/rP9u7P7hl7CsimTrdjQHg6x5bwQPC
         SQQ+jHjZFP3h1QyQAGrE0UtsyNMKqfhIlRqdnuTHtxIpO4UfkGmLbhKQAVmWl00Bho86
         T/Rpcm/szyleYiBUiABkvKKv8d7YkCSq0kFf92O+T4HTC7kPpxR2q9jf/G1Z8m1Y9ANr
         2RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705978352; x=1706583152;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBawzcIsmutGApjzKJ2fwSLOeAdZ6Cj4Ps7r/9TWWyE=;
        b=iAupcbOVsKIEVUFp7QA8wH1hQoiVN9k8lZOqm7d4ITcQKdl+TV/tOrEDcqEzVnJ3qj
         stq9yJuSwpBWE7LqzCpGQ7a2DGIPhiSDmT8OH3FM5HzsaBcJInbc31+52YSqQyLEMrmP
         O+Ldsv6C7+RxKz144krIrzuwsWJhgDyjxG23NdtSV/nSGNh7GkBKRT/hoTEmvF/88RLm
         gfOLg+Tzp1dCgrU2bFqDicrIeO+AfTC2Q+45/x6sh2W98M3xuccNlGZNmyMDXsFWV8r0
         UVPoNydVqLt2x2ihcFzSc6nX1wsVDEifdofxpxol6PDQIG5+apLN9iu5uZuof9YVrSxG
         AXwQ==
X-Gm-Message-State: AOJu0YzFPChREMZbWRgBmPFKDKpWIMjIiW2LZvKyXc0aGMOHqlka773X
	WFiS+VaLl69G7Scvu+lU6b2tztwGbUXQhS1BkjuLqIOhK/vGyZTAnPpqC0w=
X-Google-Smtp-Source: AGHT+IFULZfYRRP+LLsk9E6QO2fgaftbNYkDSP8tWOUgeAlinRvUlBZfeFvzmBxfnghLXFO7/anQJg==
X-Received: by 2002:ac8:5915:0:b0:42a:4a81:25f7 with SMTP id 21-20020ac85915000000b0042a4a8125f7mr225787qty.72.1705978352103;
        Mon, 22 Jan 2024 18:52:32 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.47])
        by smtp.gmail.com with ESMTPSA id z17-20020ac875d1000000b004283f2208e4sm3060019qtq.87.2024.01.22.18.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 18:52:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4f4ba04c46b432b5f2a95bb75d85912bcb937cfb.1705427537.git.pabeni@redhat.com>
References:
 <4f4ba04c46b432b5f2a95bb75d85912bcb937cfb.1705427537.git.pabeni@redhat.com>
Subject: Re: mptcp: annotate lockless accesses around read-mostly fields:
 Tests Results
Message-ID: <ada09308-4902-24fa-432c-eefaf72e27f0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2024 02:52:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6203989608366080
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6203989608366080/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4796614724812800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4796614724812800/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8a9166777803


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
