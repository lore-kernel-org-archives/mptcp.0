Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84E883A
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 09:31:01 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1c4c7a83bcdso3345661fac.0
        for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 02:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692783060; x=1693387860;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuoG4a/bsZE9YVnPp5J7/J7dXzzKRIC28DV9gkNEAV8=;
        b=muJjjoZY9uFczMccM1eghkYxt//9y4ZuvK8qs6cRQEcj5LWJlqG6YDqeIDHJs6UHZd
         DvXNnFOK8dbal2mlrZbPAmRBuabtD5WOyAhpVLENu0RXWDtTsb4/pcmz+v2T7p4K2u/q
         +Ak6pHxf2nz2dpZChw51Hv2yigMVu4nPeqniUdp5p7uqpft+tw89IH0FG5MiQS5qZr6i
         rmshEBEUXEJRrhNV09cCh3rEDwtL7gCV5GaQcxPSlcrq5rjSSzshd3aa990mfbQTGXZl
         aCmYURwdEWIIewHQ4rAwy2BcFtEWmXfdke/3xOSKRKt6WFvz/R84q6RTMXY12dheFQKq
         /yfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692783060; x=1693387860;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fuoG4a/bsZE9YVnPp5J7/J7dXzzKRIC28DV9gkNEAV8=;
        b=ZGHXcYxpSwnNF5VSs+nA2jjYsr8MC1wT1504eyw76q0Y0ortQecjEBuvaw0z06Fo2L
         dqbScQ4goqexLeuHMoNGWenJnaXPRcY0i9Z/Aiuqoko0NfpPXWr7HIxHpAKWqbRjkEk/
         IXmcoblxR66ezVSjgF0qWLcMbt5+0ECyKMgPP59GlBKqKsRuRU6Q6k6w2aWJc62XBesp
         m+tEIuGgAyegLdPlfz2IFvKPdqk3JwGTfU/GZr6+vx18Foue11qXbBUnzA+CObQ6SvMg
         ygN/+9VX+4z5ZIhmy384ypV+w7uXiXHkHdthrHuQzBduJkGYZh/C14FxiD4WNm9GaLdn
         WDbA==
X-Gm-Message-State: AOJu0YxhM4qtBt7J0vFXeO+coGUkdImT7ehYUP4eMYW1maazZRD1pGRo
	7fnvXDg7gDB+ESUiX4ckIW9eWFOOXA==
X-Google-Smtp-Source: AGHT+IFP5QHFAcKXuRj0Tr6hjqqIeriJXCyccj8JkdlWDsIhOxD+knumOay4pHwrPGQ73vQ/95cpjg==
X-Received: by 2002:a05:6871:441:b0:1c0:d0e8:8ff0 with SMTP id e1-20020a056871044100b001c0d0e88ff0mr14016622oag.17.1692783060329;
        Wed, 23 Aug 2023 02:31:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.178.17])
        by smtp.gmail.com with ESMTPSA id i19-20020a056870d41300b001c4e85fa00csm6635748oag.49.2023.08.23.02.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 02:30:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com>
References:
 <0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com>
Subject: Re: mptcp: fix bogus receive window shrinkage with multiple
 subflows: Tests Results
Message-ID: <55ea81a8-f9d4-e94d-5cce-05765a97e668@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2023 09:30:59 +0000
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
com/task/5348508102819840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5348508102819840/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4644820661043200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4644820661043200/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6474408009662464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6474408009662464/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5770720567885824
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5770720567885824/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b4bd4dbf03d8


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
