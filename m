Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB92F25
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 11:57:28 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id k7so3688500plg.7
        for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=RibYIg8BaANSMuo23lCIG1nGNt6jZFL6tMJLJxlWgK4=;
        b=ApW8Cr/8GRQyZUDDE15DKT0AJFx4q1xzywPuMETXvJG1qh7kb64c6M5RAKfXef7R2V
         gyLNj6l3H64ic4Sg7842rsaF1EWkiAQV+NqIGX7Qocfn/7G8O35tucRSLsVENgT/iSRs
         Z5duhwX+dnTpqqkG6lkbd2FXHhkWqQxzfOroV4RWcHa0HRxxoql7nZTXhSvSM3HV2e2D
         QjbhFdGQpZQqYcAe0O0a+NxSHpEjQUypND1h0IOyDXQ2lxY+47jv03NeZDbE/wMm9mqf
         PSlVIcfBGu3Jc/ZxqG30u0A/nGzMl4fW/gpuxVDZtimEaAaeloSfDhiIcomBVs1ruemP
         qzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=RibYIg8BaANSMuo23lCIG1nGNt6jZFL6tMJLJxlWgK4=;
        b=qg+WMpZJ62yQarCIBEp4D5b8R1X5RBibgLZ/TVJUbeOLuThk1xASyC3qIUswfijhro
         wJg4xZLv9i0uLjlh5Jq/w00Pg/EyFV0X4yADGs8aR+raHZcatP0f05R9vonOLw0vDwGX
         OGJC+QEjN0f0Y2PgifjWKsS2eJpUyinhXzslltiPqOwDU2pj8ZgqXKGtJ5XovfEF4IJc
         x6oRoiP+VVqBt4UTHrMolgHInveQSZTOsrTMJq1+ZBuHA0WwB7hpeN1syMfWM5UDJ3Ei
         El+eI7b1DRNBj2EGU4yhjtIF75JJqXNaFILfFc/b2O8Myk1cGsW3TmAqYs0jwAehJ2/d
         5P6A==
X-Gm-Message-State: AJIora+r5hFD6BM3Zh1la74kFNJb0/2OQufs4Q/L9ZuTySX+ggFxnE8n
	6Phn+COZh+c2z6SyeJeJRA==
X-Google-Smtp-Source: AGRyM1uwyFt1hrWHhk3NH2ZcQ6/c+G7DTSqEvG1ZmfqUWHHm9PKydPn8JfQRRSaaKTktIeCX8GQhHg==
X-Received: by 2002:a17:902:a989:b0:168:fbf5:56d8 with SMTP id bh9-20020a170902a98900b00168fbf556d8mr9138042plb.58.1655467047533;
        Fri, 17 Jun 2022 04:57:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.38.175.255])
        by smtp.gmail.com with ESMTPSA id y186-20020a62cec3000000b0051b9912889csm3590577pfg.101.2022.06.17.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:57:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <dd32766a57e98209da3257e9c68980a3b8727797.1655460262.git.pabeni@redhat.com>
References:
 <dd32766a57e98209da3257e9c68980a3b8727797.1655460262.git.pabeni@redhat.com>
Subject: Re: mptcp: fix race on unaccepted mptcp sockets: Tests Results
Message-ID: <de84002f-5c68-1d49-0e44-1761f60e0602@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jun 2022 11:57:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6043371033591808
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6043371033591808/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5480421080170496
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5480421080170496/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/aed85d6d96bd


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
