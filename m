Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF62AD53
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 09:27:48 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-64d18d772bdso301309b3a.3
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686216468; x=1688808468;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GElrfSaubLFcYv1MPgrIFThgs9Z92VjvQy/CmiKYWAo=;
        b=BkUMDz9mHrGIp07CgG6oDaU+ludOV9GF9D3x3ZdPW1V65I7KSK1cK8/hRm4U1UiTQF
         mqNbKp0Fo0qVqUg6iy+KWUubo+XfeTAnLI77glE4VkzmKHBuZY0inL5lvbZCXoa4THiM
         TRW1330Zp2ReDt7wxtNgzWU0UvliWoeQa8nTZ8wPeffSrRSLBHG0OlcAbIMb+bB3foxi
         XWABzovrLlS0qQErRtNyRfyLVYToRe0f32f9DyrqieWXK/bHDv8GRIxKVWsi1ljmxTDH
         /OiQRP33jHx9kZ+95UnVsgOBhXek9y1X5eC/PNVEPdUeml6zebf9Y1cIZ04JsNHOCPI+
         MkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216468; x=1688808468;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GElrfSaubLFcYv1MPgrIFThgs9Z92VjvQy/CmiKYWAo=;
        b=WwlEoUJrMFBjGGveCK7/I+S2HJ8nMdxk3W+LOMbsUdXoohM1UMfhKAr/my3DVjo8aF
         DYQIsiTXnG1VHEQkMByKyU12JDCbGWMyTout/i+eRuq6EHznphsR21akJ98d1VgzjIaU
         35mHm/2qhpGD74Twx5w7ZmCZToEPJwacMPSxjJLvZu+uGJY6JLpjjPufllk0HEocVxmh
         S8vBLYKgdkrLc/v8IW1d53XLKHBkkhhUvuGSwpw0v8KDdWILuxvmEPxSkRVjr2QEB3hd
         Tb5K3Vnenz2T5CdllZhT6VrHNMNOd80JlUPZBRUxCILGHIZSlESqaqvUgmY0cTK9XN6f
         //mw==
X-Gm-Message-State: AC+VfDzC9bzkpORb0i69MUb/Suhv8UJmrN+lpkkYcHxKdOvrjl1SUrF/
	1CveVTCOysG6wqjbkOm+6Q==
X-Google-Smtp-Source: ACHHUZ50bwt3j5IKlFxI5J8ShMPknSED+e6ex4foxLohO8ZT73zLjJDqgoNXVdDUUNgK+V0NphPmew==
X-Received: by 2002:a05:6a21:3944:b0:112:2843:b546 with SMTP id ac4-20020a056a21394400b001122843b546mr6102575pzc.58.1686216468085;
        Thu, 08 Jun 2023 02:27:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.70.71])
        by smtp.gmail.com with ESMTPSA id c8-20020aa781c8000000b0063aa1763146sm751780pfn.17.2023.06.08.02.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:27:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
References:
 <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
Subject: Re: mptcp: fix potential msk leak: Tests Results
Message-ID: <c83d56bd-9f91-7da8-068f-31da06bfd71c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Jun 2023 09:27:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4855827119472640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4855827119472640/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5981727026315264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5981727026315264/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5418777072893952
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5418777072893952/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6544676979736576
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6544676979736576/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8579858a269b


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
