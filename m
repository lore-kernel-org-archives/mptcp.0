Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD625ED9
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 14:40:48 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id q11so1719004qkc.12
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=5xTVYC9RwSD+jJ3lYPsOmZPBeaATNfS93ZNY0aIWhpE=;
        b=mt2/Y25j7S1EOwfXZWFba/RIFIqywp0FHIjieZQLxh9IRpwlucKADi2DteIuqs7PxC
         N4MLUA28mbZc/nBswYCnU4vLa4ZDjETIJSXFxKqRBuxUpYlQnMPkPFt68WLsQdqZnnmF
         6/yhWSt0QunAJWODlXPf873Y0m+vbSHzzWRuevfRporLSaNaEACixMzAqM7cuXA+nkqV
         +u+TEGXGhU6eLlUWUc1CYBYYNhnqgMi2ZJ3tLb+BhGwNhtKLifFMPfTBcBXryIMr+NIB
         iLb5TYIo9wmVb5MgfzlARjogXc8Zik0NS2rHLbMYIbHepcIE4gvg7t+4B90K3EktCAP/
         OQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=5xTVYC9RwSD+jJ3lYPsOmZPBeaATNfS93ZNY0aIWhpE=;
        b=EjrCaGZA+WbXQrI6SyNAo1GWrc+k6Sunpg4fEss6B9ec+3hq/Tsfp2/Y4egQg4mKg2
         YbUObQcqEEi1RMM73Spdjf9f6sIvMEXbg4a18MmiyzsjVYLHXpZvDyDIp7+7YMt1Q/hG
         n13Ya8H27j9PiL/I7zLdhogI/MHmBiiSYkFSklF2KIKlnJyRwAk9R/88bPUTGvJm8yXJ
         qNQAJZRXJ4nhzI7Hd8Rn/NdEjRp5tQ50bkHOLCsz709X7Z2GguRCE6h0nFeBRWbACnnq
         jwZqhPxne6h9tuOj785GaDw4mE+9TtoXMHVBjoZ7bRMsWaehAtMsSnpOjLXL6TRSNQLn
         bViA==
X-Gm-Message-State: ACrzQf2QMZP79cXZi4iyz1Rl5BpkkeceV0j6/eBd1tIIBD+ksz4dtNn0
	Jz3IIvhFBo2oMltRSNm2QQ==
X-Google-Smtp-Source: AMsMyM5E04ge/kejEO3He6UqwR7rzxGXtOJ93lObjVxj6DTJPy657syUXlJuFqRwC4eCx9MMA5OjBA==
X-Received: by 2002:a37:a4a:0:b0:6cd:5263:1ba4 with SMTP id 71-20020a370a4a000000b006cd52631ba4mr16325112qkk.203.1663684847486;
        Tue, 20 Sep 2022 07:40:47 -0700 (PDT)
Received: from [127.0.0.1] ([23.102.98.41])
        by smtp.gmail.com with ESMTPSA id d24-20020ac847d8000000b0034367ec57ecsm98402qtr.9.2022.09.20.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:40:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220920125243.2880-8-dmytro@shytyi.net>
References: <20220920125243.2880-8-dmytro@shytyi.net>
Subject: Re: selftests: mptfo initiator/listener: Tests Results
Message-ID: <9659995c-ff16-bb79-112b-ab9f7d983d43@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Sep 2022 14:40:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_mptfo =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5895896842895360
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5895896842895360/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_mptfo =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5332946889474048
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5332946889474048/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/413c19c617ef


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
