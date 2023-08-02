Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82B566E
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 09:17:18 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3a4875e65a3so4709173b6e.2
        for <mptcp@lists.linux.dev>; Wed, 02 Aug 2023 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690967837; x=1691572637;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMkUHTr8U6XGzg8qUX+PWPclE6W/9+r9UpSJjaYf8kU=;
        b=IsPQqit4P84eaJfu3Y0rvnfoI3UY7yge9Yan1yLTPtgZ/aCLKAzLcU1JXBS17w0l3D
         6m/bPUKtU1rnHJ4sQtjsiPIyK5YB+58coe3RZzyewoxPTvN/FHQI/kU2/MUbuSTsriL2
         yOf2mwdu9gsZh6s3RsjvqM1pT/VaAb0KvhOKCYVBROGgTuJCMSe2N951R/5gebOSwj0z
         dIMms/9vCH40MRospxLc8NQbhhrm+6htKKQwQ/C2Cox0K6PYNzsXP/ps5Osc7GBIgpFy
         59AOlaDhWUc1/XlIO/FlOWbzbLEPx8HLKRjBbm0EvXE4DUApCEuU2KiZPSeAMHVlWAZy
         1AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690967837; x=1691572637;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GMkUHTr8U6XGzg8qUX+PWPclE6W/9+r9UpSJjaYf8kU=;
        b=RA3twqzMST6dfAUL5ISNcF+yJO2Wx7ErnTPUDqgpsQEXMRhahjF/ypbxiNxTii1sy4
         uKlHtlIjgV10eGDs7wAJ8Zs+OIrIfEGowOQQk2UbkydWtacetwSP80WZn+MvREBGw3lF
         OE499CXqG43DbWencinboX/Bi2pOGo2NfpRirMX+IOehs2V+60sO3uE+x7tSu0NQI6Ss
         HpAJBFlZd5OztPf/uAIP7obOjZE1/zlNyMnVYPsGSTkNhfhQvcuvf548jYbDooGrnvHj
         7a9Vr4YreQdncFuTn2EcHToy6sdzPxKImId6wngTf1qgKQ9eswSgiqas48S+29SALV0t
         64AQ==
X-Gm-Message-State: ABy/qLb2k2WPzBbZrZSSYogVxYoqR6GBfP8hyVRYA/ICHQu3/JNXcQyG
	UK8LxoLhCpNGWsPt6nzrA3/fVjjnSfZf
X-Google-Smtp-Source: APBJJlFileyH0+p+o4C4ibcKNCctdkwSNeu48pOd1Jedu2wrJdTo+8uzjzS6EPAFNLNNU4eCmJyXKQ==
X-Received: by 2002:a05:6808:148e:b0:3a3:f92c:3f38 with SMTP id e14-20020a056808148e00b003a3f92c3f38mr19446773oiw.6.1690967837397;
        Wed, 02 Aug 2023 02:17:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.78.81])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b003a3f922207asm6060335oib.1.2023.08.02.02.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:17:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <322ae693257df0c5fcd8f9254e062f394fbeab88.1690963606.git.geliang.tang@suse.com>
References:
 <322ae693257df0c5fcd8f9254e062f394fbeab88.1690963606.git.geliang.tang@suse.com>
Subject: Re: bpf: Add accesses to bpf_skc_to_tcp_sock: Tests Results
Message-ID: <8f6acd5c-3ff1-335b-b85f-3952838d420f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Aug 2023 09:17:16 +0000
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
com/task/5661632492208128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5661632492208128/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6523150402322432
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6523150402322432/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5397250495479808
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5397250495479808/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4693563053703168
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4693563053703168/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f3fba10e46ee


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
