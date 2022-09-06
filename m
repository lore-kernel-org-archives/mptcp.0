Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6B5381
	for <mptcp@lists.linux.dev>; Tue,  6 Sep 2022 14:29:06 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d12so11483449plr.6
        for <mptcp@lists.linux.dev>; Tue, 06 Sep 2022 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=joDw92iiOZdOK1SKFSEUxVP0GpO+b6E0WFIbKbU+jhs=;
        b=NsHBDsU+NGUqiGgKim3dE7LNYmm1tzrkfiBQKUwLcOpVM45D51VXGzoxeAu4iMvmid
         XrBEykcZYxgJkWVua1oO+9dwz1PaTU7a/734AekFyyPRTew5u4dL6Lrznn07pIl3ge0K
         E92cxG12IFhQrH3xBccV9ZsiiSdoCfS8nQLcT9QcpJ/vljUOetyRZ/axXIlX3cHFfQaq
         SKU4J8BJOLgwR5CCJ0rjXr5JXO1F3Jj0AWZ0KSPlKNAUOFoIDEABids4pXiGk8bKM4PD
         S+7fgqa4A+gd2GYlKTTfJR5xWr6GV/KeKvw32d8W5hnt3ol8zJBWrvFQHzZ+CbCFSpcJ
         kjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=joDw92iiOZdOK1SKFSEUxVP0GpO+b6E0WFIbKbU+jhs=;
        b=4mvGcVs7oW/SkT5sHefsS4ibaY8n9xIapfwbs6h2/TYfb0G8rmXaN+/3BhmCML2c2q
         AIeuif2oWLAIVe7zUgthf8hGp2aeixnPiEDg2hAkSBaKLwc3qa8Mf/Pdqsvj99iPPt1G
         nFsh+v7hkRwUp7iyyCMBNcBomoyaUXPi+ZiuAPp8jpuj160lFqiYc+CwOnUTRnTclmat
         cVPzb2Aq2xgy43EiLoU48XIu3PLAf/a7sO3h73EcGdLarGfUnWNsgX0Flyqe+v0IxfPp
         IU9K0UG90qiB6PJMM3BQU2kJqFjN+AuwLzZX/MId7T43o+/IWmuGbq9F9P71By1yZJaX
         MLGg==
X-Gm-Message-State: ACgBeo34SC8w+1pNmtgQ/v55ioRX35E/Uo62rQMMG2fEDIleEyyTkozv
	kx8fTUKtOyer6xJ7INmC6g==
X-Google-Smtp-Source: AA6agR4g3sNrTvc99PCz6JOZKGC4lxArEybKWOyAjxzNLfybm7uQVMi2ys00pyK+kx06Pwn1uGlCug==
X-Received: by 2002:a17:902:a40f:b0:172:d0c7:ede1 with SMTP id p15-20020a170902a40f00b00172d0c7ede1mr55204361plq.88.1662474545754;
        Tue, 06 Sep 2022 07:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.3.216.217])
        by smtp.gmail.com with ESMTPSA id a2-20020aa795a2000000b005360dc9c45csm10280579pfk.43.2022.09.06.07.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:29:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220906122025.743592-1-matthieu.baerts@tessares.net>
References: <20220906122025.743592-1-matthieu.baerts@tessares.net>
Subject: Re: Documentation: mptcp: fix pm_type formatting: Tests Results
Message-ID: <79296f71-941c-78a4-819e-9b30dc5263ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Sep 2022 14:29:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6440432971284480
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6440432971284480/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s):=
 selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5033058087731200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5033058087731200/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/578f14d513e3


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
