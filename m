Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF5A930
	for <mptcp@lists.linux.dev>; Fri,  4 Aug 2023 12:26:55 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-635f293884cso12215706d6.3
        for <mptcp@lists.linux.dev>; Fri, 04 Aug 2023 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691152015; x=1691756815;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwTPeZYhuNRcXpidHE7ODi8cjSPhJrVKG4eGh/PpjQ8=;
        b=ETkIueJ0WcK03R+IZ25enhmIIdxRvXyzeMHdfm1Mx+CCVpKrvzYuFW56O/0SyKq72h
         ij7my/B5oaSR0Ii1B0PAKpItguNo+I8XsqG6CnVIMoLtz9+SUyFp+hy/U/iCyaI5+DZs
         8A6O0x+/dUOAyJzcfJmajD3k58ptx8ZyapBPXg2CFMJXDGZMtheN22p4Raogaldy15B0
         07mlxd5AeTc0TR7IIgS35JLfmEBBXU1Hmrbl+VyfI0GwCZ/8VKTrjPzTQnkKaXHHfzGg
         n5NDmIN+3ugRHTCQO0JFsS6KBZTO9J0qbEQ4MEbf+ua5EMHKZQQlxVMXPhR926+9FiIp
         NShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691152015; x=1691756815;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uwTPeZYhuNRcXpidHE7ODi8cjSPhJrVKG4eGh/PpjQ8=;
        b=UcnkWKoYqJ+H7ivO60KhHQd1GsAycSUtTt4/a7MOLL3MFPFRl13l92QQ2J3mjKNBaR
         ncOc6lBI9vz7wjsuDK7bDj4SiZ/y7Ckaxn9QvmlzrZ7W6cks0ADyHegAdzbA1mbfOX+E
         gprBtjT+2GE4nScxcht3E4p0ZSbqfp5bfFHeRfwGJmYfcoTjMe2+sr9t3nDCmtqSxYiQ
         jg/imERDrzaguKahU6wGbftRAifMghSbPpw0AiVulh3WF1FR5e8Y7SVAp50OaGO7d0s+
         tWWPzxZCqB78utzWRHevWAtRrhqm1RflKjY8b/o1EjFTJeXnojdSYfIkGVLBC2JaBG66
         DuPA==
X-Gm-Message-State: AOJu0YzCm2w40mmQKAFXdF1d4l/vIB0al79Ym+qNz77xw0A4kYzD9T4W
	UVtEtWZwJc2+BrsdCZauYQ==
X-Google-Smtp-Source: AGHT+IHmeMA6qWXYtqb0hhpnSBaDgwoYIXLnsO/TQkIR44PUevQXqH0qgtcrTtRR89Yic7PncuTR1A==
X-Received: by 2002:a0c:dc8e:0:b0:626:16ba:539f with SMTP id n14-20020a0cdc8e000000b0062616ba539fmr1428507qvk.5.1691152014703;
        Fri, 04 Aug 2023 05:26:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.36.119])
        by smtp.gmail.com with ESMTPSA id j2-20020a0ce002000000b0062b76c29978sm626235qvk.6.2023.08.04.05.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 05:26:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1effb0a793140532be749aebbd7912798245745e.1691125344.git.geliang.tang@suse.com>
References:
 <1effb0a793140532be749aebbd7912798245745e.1691125344.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add mptcpify test: Tests Results
Message-ID: <84cb97f5-daa9-c994-1f7c-04b0255bc8df@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Aug 2023 12:26:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6058655376736256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6058655376736256/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6621605330157568
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6621605330157568/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5495705423314944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5495705423314944/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5233749210693632
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5233749210693632/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/352004bd53be


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
