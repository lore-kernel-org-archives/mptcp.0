Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518693B789
	for <mptcp@lists.linux.dev>; Fri, 10 Nov 2023 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVEgmn+y"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7a93b7fedb8so88468239f.3
        for <mptcp@lists.linux.dev>; Fri, 10 Nov 2023 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699656798; x=1700261598; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvdAVUVdtC6riEu72SJP39aHPCa9YXqt1UH0U8F68gE=;
        b=YVEgmn+y2G8GA8d76SvdHBvbKIk0dmVT/2+dzqlAJtlSSP5ri+Nrm1FLGyrhjk78Yx
         uz47TvHBXiDdPIbrOzDLOl+4qHihJHNg62AwNcRIoUG2CXFf+V3xJ8QM7w9VJSz6ew0Z
         i/dHOZcgVCIxGxQH0e+MX1xbqkSSFF8Zy9seDKkiENH/uLlUI1jVMXViMv1m6RKs9Gmv
         dwwftjj/Cq5u2U01GaQjaGOWiqUmcWlX8S4VGMnN+k3iDeukL5AAhIZ02lx6j/Y13qF5
         gLAHtEIYLRaUW+cfDWDpbajwx7plSiCRaJUtkybY3dMY1r1Wn5+1TOyeM8i7rRna9Psx
         wACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699656798; x=1700261598;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WvdAVUVdtC6riEu72SJP39aHPCa9YXqt1UH0U8F68gE=;
        b=BrPrLmVRAzacN+q9fj6btzTilte2GZitZE+9W8nnWPBR/iRPlHGneIzLJNwrKXXtty
         BSZ03/JFgaW+d9u9NTmG5Cbj16MPjIQDpE1ah6RXfHGzReUIz0yFq/MsKZT8TnE3Ifp7
         vXMCrk731UITVnkhoIB9RqmKaogW8DVqGCp4zNqVzQd7cW250xdRxueHmA+13VIU9gKF
         lKLZp9+wfAHtUYrBxZsUyzdQuycYq9Uf5jWpm6DO2KLDWE8SNmCHBFnjQl+aMeCBeDAp
         I8pwFF4OhCCmNxH3Wf/A1mzUO/LBESHF06xCsWCiEltJd2UIPPlYlQvWet9J2GqnZAbS
         erXg==
X-Gm-Message-State: AOJu0YwMjPUHelhxjVj106n8yb4OyjePrjOM7dKb5RBoaRjUwJ7z9OzK
	mvTAUZFrGUv4edlDXQGUNQHCfogIOw==
X-Google-Smtp-Source: AGHT+IEWvNJ7CAecMUwFnLaMexkK8DZeqwYw/WAr6jw6LoZb93aOpSiBJXZQggBmLPmLbc8Jn6pV+w==
X-Received: by 2002:a05:6602:3e91:b0:79f:bb82:7a7 with SMTP id el17-20020a0566023e9100b0079fbb8207a7mr811228iob.2.1699656798303;
        Fri, 10 Nov 2023 14:53:18 -0800 (PST)
Received: from [127.0.0.1] ([40.86.13.176])
        by smtp.gmail.com with ESMTPSA id dl7-20020a056638278700b0042b068d921esm116051jab.16.2023.11.10.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 14:53:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <720d67a275179d96aba05cccd56a98f10da47aa1.1699647725.git.pabeni@redhat.com>
References:
 <720d67a275179d96aba05cccd56a98f10da47aa1.1699647725.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: fix fastclose with csum failure: Tests
 Results
Message-ID: <1582db89-b2b0-5f3d-c922-f7d64ee7d782@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Nov 2023 22:53:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6328130965602304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6328130965602304/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5316114733858816
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5316114733858816/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5927627949604864
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5927627949604864/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5358215681015808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5358215681015808/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/288abdfafe00


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
Bot operated by Matthieu Baerts =
(Tessares)
