Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483B3201
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 12:17:27 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id n20so457977pfu.12
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 04:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/XpEEIsrLdE2RFW9frcG16E1lt2IghdUvIFRxPD5oo=;
        b=n48I/8NikFnvqQAJUWM757z7fpVovS3XQuVTuJOklJi8PWa6dG8ffE00XgRJa6Dfnb
         R4IIjO4enbdMZmIfnEKYVV+07UOG02TbvauQKQAtbIcBYK6GqsPHNyCpXL+XOwSHga7B
         fpHaV8sXmz6q110vKuZ20iKBCyce5OzAeFS57cFxWGoaylsjH+u92xqfIipc6KAuXG6/
         qxt+y2px6AsMfEuKbyPyFeNF/VzUnF441nB15FufbSdy+ko6FOu5+oQ6JXCZ9Cz0bB5G
         vRBCZofV4zOl/EzMunLZVfQfr2gHu9aLiZPNEOPxgR/Olwgtw1bMicDVpXFJ8OsCZuBX
         9CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/XpEEIsrLdE2RFW9frcG16E1lt2IghdUvIFRxPD5oo=;
        b=sUW9FLJ54pdRuZtLL7Sw4cdY6fxTomw3K+A6c0vOI3NkTG8hCY0JKj9td9Ez/M05HL
         La8yVkbrGk0TGFNKyxhN4vtE9dTTIbmX6PETzsPBRn0WNs5W+Rn2DXiE4KcXLaveJk83
         j9PIMYcoujOKu+1kXLe0Htz9rT6s1Id9Hr0CZ6O4ltv3eHT+32iDQAa2BiErb8t5YVDS
         OWSZqdALEL7KFDp42Ksf8ZNGy8xFARfRUCEoMZKYeWz/lPC9YcM3rW6tCzcG5leQvV7q
         BcRM6cB0Ddl3iZa4lwaA+CkjhcXFE3eCpW5eiJBwWAlENW5KYf5nt3tkjQKArdsC6Nu2
         cwPA==
X-Gm-Message-State: AO0yUKXNQk8SBvzcZMHV9Zaxy35ICTniVbPhKxjYOwq4+BIT6hezJcum
	+zcbo/wYdBv3zPKvSPz5HQ==
X-Google-Smtp-Source: AK7set/QP4Y+KnSuW6xL+dVhLvIWTzUBBft4o8Jtbr3MokIWltaOB4naBZcX5P6g/qZpi+HxJmC9Vg==
X-Received: by 2002:a62:38d3:0:b0:5a8:d987:d012 with SMTP id f202-20020a6238d3000000b005a8d987d012mr588653pfa.11.1676895446399;
        Mon, 20 Feb 2023 04:17:26 -0800 (PST)
Received: from [127.0.0.1] ([13.64.213.130])
        by smtp.gmail.com with ESMTPSA id j13-20020aa783cd000000b0058da56167b7sm7552730pfn.127.2023.02.20.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:17:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230219070124.3900561-1-liuhangbin@gmail.com>
References: <20230219070124.3900561-1-liuhangbin@gmail.com>
Subject: Re: selftests/bpf: run mptcp in a dedicated netns: Tests Results
Message-ID: <615d280d-e610-841f-2956-73386d225f1e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Feb 2023 12:17:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5430059792596992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5430059792596992/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6211361403830272
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6211361403830272/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5852272257662976
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5852272257662976/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4726372350820352
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4726372350820352/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f0fe5983fd4a


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
