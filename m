Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9481800B
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 12:18:48 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-63cf8754d95so18741836d6.1
        for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690805927; x=1691410727;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8/K3fWTb0FYUAKD323r4We/W5v34oiNlp8aftrhkUI=;
        b=IQLr4hbUiVlS36jcKg52y+QYZOEaYOJWZW9GW1LggXwOs5/YNVHXKzidnWxRNvci7p
         ALOBlvnxBS9KKn8Vfwp5wuBkc8wqix+hpOhLqukXF/PDLitx8M+1DeqvVmVDGdTdzrfs
         2LN+nW1MIn+oYYEweR4T7ZeO6HsFlEmba8uEy2y82mPhGmghtgS1fvfT63Dr8TR8Hxte
         gUjV6cWeGAw7S0rGBj3Gl0QC6EsBGy1svSG7UfDTYZspfxdem3Zfa9XzlopFIeNFGtPE
         MOTDtS6NDyOnbWrAMClvs1a4yfQPfv7gk+2W9RDW1nFrVBGDto4icbm1Bm3qwnYrdihi
         jQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805927; x=1691410727;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8/K3fWTb0FYUAKD323r4We/W5v34oiNlp8aftrhkUI=;
        b=fgGHajvFa5CuYtwsJnnyq6nUgS3rOXPNaC9qoulJctD2mzbeWWcEWQ1WqiyOsErbmD
         B7BCFO99ij3cI6WhwjTA+ILnJsjUGTzG2/LyWlFbN1/VDE7mGI71YdTOqhVHsWi75Goc
         0gFexnZzTggK2LUWYP4sRGDKaEwI6LdRe2gFiSmameTZ7hBPZ4PNiDvM/OixHfFAC9uc
         ZDAstZEvpQlrwKDfQPNbCKSF05+RV2IsxiPHg7L8pHUBoFeKB6AWgYH9C6tLwoGfT/P8
         ExcegKYEAzFWRtIkaYCoki0umwDSDqVCm7v+o4YzbKJJauM+oJxvsBsqHGd/FOLobFeg
         IlGg==
X-Gm-Message-State: ABy/qLbqVuhXzFu5ojNabdf9rtrLipgwn+ePj9eiMimMB5dXSRelq1XW
	4RaD5vNhe/6LDiTGY37vUQ==
X-Google-Smtp-Source: APBJJlFLt4idXTJMSdiXMN5Jn3CIWgpccBCLDJ45z86AVwSy5p/DVk1IHCOIvNqeR1lJOU4xu/aIHQ==
X-Received: by 2002:ad4:4b69:0:b0:62d:eaa8:27e4 with SMTP id m9-20020ad44b69000000b0062deaa827e4mr7198967qvx.36.1690805927416;
        Mon, 31 Jul 2023 05:18:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.16.117])
        by smtp.gmail.com with ESMTPSA id o18-20020a0ccb12000000b0063d48fc1ae4sm2903031qvk.93.2023.07.31.05.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:18:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d2bc86f8116310c2f3b2931fc3565ef7cce17027.1690801329.git.geliang.tang@suse.com>
References:
 <d2bc86f8116310c2f3b2931fc3565ef7cce17027.1690801329.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_Export_more_bp?=
 =?UTF-8?Q?f=5Fburst_related_functions=22=3A_Tests_?= =?UTF-8?Q?Results?=
Message-ID: <2b6d1762-4565-5bb7-a1e5-09e80a10feb1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Jul 2023 12:18:46 +0000
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
com/task/5989050666975232
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5989050666975232/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5426100713553920
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5426100713553920/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4722413271777280
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4722413271777280/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6552000620396544
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6552000620396544/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/23c0513506c6


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
