Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A311CA9
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov2qFawW"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3528bc102adso6707725ab.2
        for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697192287; x=1697797087; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgHyA7wdthRhljGN8HI7yZQaJ/bX31yuEjrDQ7sU1Lc=;
        b=Ov2qFawWWLqCXYUg4WHZ4AuPo47TtJ+GHEiOwzQ/MlC9bj/+mqdTqbpi8wluVY3qvJ
         AORJcNKym+vZH76lOWbMeM+ZkBa8oDAe1eocWzyEnvTpwhtAj0YYptAZK+rbzTcbMQEJ
         Lgu55zjzUqz6y5y71VKtBjWiSqlBKycPijemhwDRc817crX7bSV3KcgUSp+hAWtzIT/r
         /wxUg3RfPgcGQZhGmJkMRVe/1NmVOTbL0nSYie9tOOc3Ef4zG9UFJF0qJHYsgbFBNIHE
         rv/qbvHz0RMsV7pqc7BPVs0xEtYiqc9o90xMvGrubu9B8crDCE98D9CX/loVXKg3bktF
         HfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697192287; x=1697797087;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgHyA7wdthRhljGN8HI7yZQaJ/bX31yuEjrDQ7sU1Lc=;
        b=K6T9CDydPXRAMQ4E9g/FM84vsV+1ztWrN6gaVgmHpgk7YHKA2zb/xBoertmYUb0t+1
         zyli7dY6XHRsb0PFknUc2pSQpv9f3tjkU0TPhA5fiGCnuGJAu/EMT5sQYC+Gy1G3+z+w
         Auwn3JF4Z24qhF6pE15iZYdLU+umG6iXKJNSaotZHzurVs21YnuaWg91YuEiHc3Zr8e9
         yki4Tute16jaIrpaqUuKWdMVECqicIXpWjlQBKzfoD+YUiMQ6cbJPDAOX+pD/k1Dynvz
         PpsPZgZwQW6Rzoa2VwzzcR7Sp/AwO7XgMMA3YlU5yvpxgxdluGF2Rb7pu6N47XKbGcbv
         YXiA==
X-Gm-Message-State: AOJu0YwvSdoZZfORbwKEOAoj5opWL8lsOdK/6iDlUTVuUfFVTpO/7PN1
	qs6f2hjSmxCS3/+XHfkJVA==
X-Google-Smtp-Source: AGHT+IHrvBIMVMboyGXstirZl/mVC89WX+ijYFLpq2zMxqfALw/rvYOU4disNvx4ywcG3DvJUIdXJA==
X-Received: by 2002:a05:6e02:216c:b0:352:a73a:16f1 with SMTP id s12-20020a056e02216c00b00352a73a16f1mr31332411ilv.14.1697192287007;
        Fri, 13 Oct 2023 03:18:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.243.255])
        by smtp.gmail.com with ESMTPSA id 1-20020a631241000000b005a9b20408a7sm1208397pgs.23.2023.10.13.03.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:18:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <594e783ea19b4a53fe4b4d77a449077dc932fa45.1697175899.git.geliang.tang@suse.com>
References:
 <594e783ea19b4a53fe4b4d77a449077dc932fa45.1697175899.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm send RM_ADDR for ID 0: Tests
 Results
Message-ID: <d64b0542-5d7f-7da9-0fc8-1d75fcc9e7ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Oct 2023 10:18:05 +0000
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
com/task/6633647055306752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6633647055306752/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5155903427575808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5155903427575808/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4592953474154496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4592953474154496/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5718853380997120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5718853380997120/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d7237b02f9dc


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
