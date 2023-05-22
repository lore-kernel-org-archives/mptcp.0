Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C11079A
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 14:48:54 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ae85b71141so29878845ad.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684766934; x=1687358934;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaNqswEKcNGQ+LEITFnF/H4BbqKzWkEFJ1DYa/as1GQ=;
        b=Y9BtDa+F0QVIQDP/kpIi03r3orB6f6rp74m4Y3G9NSVvMz+7CX8NUwzDGXnrpgypbm
         p7pjEnMm3zlqPnvUbaTrE6n8LJD7jQWYfj4Y9UECh59+cyC1FFXp76uxoC0e5EsGyVkh
         aEOCvaCH5E2s5mJORWg2gpQMQKDffUdlozlYzcrarBzefNl82cK27//4oorktpKQwVSw
         rAjq16gmqi6gl3Vu0XqGp+Upc7X/1Ej9ae8w02QDvZ9ykoRrZSGgaMzTNkpCLrRXyysX
         geqkzsMA7RGkZrneKEErvtYeyn9IalFmAcgv2DZ8b0M4qIt9oIFeCbNbjhSbtR4OdPzS
         aseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684766934; x=1687358934;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yaNqswEKcNGQ+LEITFnF/H4BbqKzWkEFJ1DYa/as1GQ=;
        b=HgwOLDFqmnOFpa7GbEOQb8G7xYxqLzfUffRHkEIluVkLsE/H1m84Org7Ahag//xxTF
         gVNarPc0TKurUwyLeMdE7MSN9omzZokHdRpAlNy3B0aMtVB0ZO2TgdU3bIMdD9KojPcS
         Mhfgy5INEaGH/gTagEi1ROUCWTDVcOV3z+QOb9Yauf4Y1/dmpGcApmN7NfQYylWVXQLN
         73s6vaE4tbtWcgQm39jfCMD2J26753OZ02FIWKyWdDlzjJXfzu/S3rkjV8pGAllK3dJW
         cPQWGcipwBkFu/MYPAsA/wwG8LLa7jwfNDRf7gAzht6Mz4GAaC2VGox9z+53txq6nPr4
         mTVA==
X-Gm-Message-State: AC+VfDxoFgUa6qdOJpP9O1jBdeLfLIAr3HMhBghZP/paG/uF0DnYHouD
	hXp/AhGqEVVe0Y/gUCxIkA==
X-Google-Smtp-Source: ACHHUZ5hku8E46q0+2O/kS/0GuBJOelK6w7V3lyfQb5Qt72J0ATSDRxfePdTRLFhBc/6J2TFxu8zTA==
X-Received: by 2002:a17:902:e5c8:b0:1aa:e425:2527 with SMTP id u8-20020a170902e5c800b001aae4252527mr11312754plf.21.1684766934292;
        Mon, 22 May 2023 07:48:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.213.139])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001aface7bdd8sm2855529plj.31.2023.05.22.07.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 07:48:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <844d9f8c87bc733488eba77a4a77e7040e87d8ed.1684760588.git.geliang.tang@suse.com>
References:
 <844d9f8c87bc733488eba77a4a77e7040e87d8ed.1684760588.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: update userspace pm subflow tests: Tests
 Results
Message-ID: <04009c5e-d4fa-6bcd-b617-4fc4630db233@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 May 2023 14:48:52 +0000
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
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5356778448224256
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5356778448224256/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 5 failed test(s): packetdrill_add_addr packetdrill_dss =
packetdrill_fastopen selftest_diag selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4653091006447616
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4653091006447616/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6482678355066880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6482678355066880/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5778990913290240
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5778990913290240/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5b62b7942683


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
