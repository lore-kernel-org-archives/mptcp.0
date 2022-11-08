Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF206182
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 10:51:17 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id v8so8806725qkg.12
        for <mptcp@lists.linux.dev>; Tue, 08 Nov 2022 02:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSbGPGb8Li+Pa/LY6cfHhn9vnjksoWvYL7rEbmW7UYg=;
        b=dRLZczYluEC+MLVUrM1Z3TyvvIkMfH48i9XIX675FRrt8a0mfiwF+xGPa326NewC4D
         zbrXIWlVaelRcnQ/P0NW2DAxaSUNjbxl3obdkdGna6AZUY6maf41yqF/DGv4wfbCZvOm
         A8mQBQlYp69rg2ROa/c8wT2P3FfMogktbtuliEgrQFsfgZB3kt0Rk7QhmoxRGfEWPNwP
         e+mYrEHcMosZ7EORH8hywENkad6OrAz88Kgiv5F5Nw2w8om6rtyRaEeCF5XnecvO4e1c
         rR7Vl0kYvNSe66XYKcQWC5JbUpJUzyWefVsL1X7Xj29ITup0bAtfbYUfDbu3vwGA+HKa
         xG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lSbGPGb8Li+Pa/LY6cfHhn9vnjksoWvYL7rEbmW7UYg=;
        b=CHhDXiagK4OfQ6x6w6i9i1JGS6dr1ZyTmP0XlDjZWoXModuWlB7TQ/lYyecXCKFiM6
         1eCgDNE0KRT/tgb0FJCoKTm1TdTjnO72ive1LAjWFMg6J4mr4EFzDvF6Botqxn5yyXqH
         nWMACTqi/aDGL4IOLtEkO8OYbUJllRiD41COZbw9AZguWXZc/RzXiEvTSCOssJcdgb62
         E73V4tzgjdiUMYuGI267jDiNtcUMKgK6cuJX2qe62cyq60tPNFsIMs5KPSs+3t78EtTx
         r+H8a9bS5Gba0sNjvOLhp1KdKEBSevjPSWqftKbCX6P4bHiv0ZEBH+raj4Ip+FIiy2N2
         gS7w==
X-Gm-Message-State: ANoB5pl2ajBDV92IBCnSqaSkXsZk4wkoIX6shQRXtpeUozyhpLK6YRRJ
	qKF0qvHvfPJJpYTKCkPlyPT5aTJZjO0/
X-Google-Smtp-Source: AA0mqf75VoP3jjdlAInVkc7PlaneepoM64kgfTUt1PZ9Tk62uoNpIpFYkUADIozczd3YtO+XZngT3g==
X-Received: by 2002:a05:620a:1359:b0:6fb:8da:c871 with SMTP id c25-20020a05620a135900b006fb08dac871mr748213qkl.278.1667904676592;
        Tue, 08 Nov 2022 02:51:16 -0800 (PST)
Received: from [127.0.0.1] ([20.168.197.56])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006cbe3be300esm9559452qkp.12.2022.11.08.02.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 02:51:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <92d945d60c7a97d26d30a7dd8dff441b5509968b.1667897099.git.geliang.tang@suse.com>
References:
 <92d945d60c7a97d26d30a7dd8dff441b5509968b.1667897099.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <976069ce-1543-7b2b-cfa0-ac10264a3898@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Nov 2022 10:51:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6199481423626240
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6199481423626240/summary/summary.txt

- KVM Validation: debug:
  - Critical: 2 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4792106540072960
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4792106540072960/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e24daa06c11e


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
