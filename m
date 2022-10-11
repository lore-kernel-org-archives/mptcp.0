Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779715AC
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 01:08:43 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id n83so14376114oif.11
        for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 18:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REn/6f42wu3Ujz8NL0Ob0M4V4AQhWs1dXX8RWkuqpYQ=;
        b=SJGiADps//J8tkwiK0cmuQYCfVb+88v3KK9gqlhVYLzy0CFPyoygjjfwVY+o599RH1
         0wrh1+RkR1M9aADIAnxJ26kWXt+af2bcOTBmXSbK4UzDv/QECtvQ5G75+0ZvA9Fj49pX
         kGAz+ncuj5h7m8N78b1mFUW/U3wcsmMLAUIfn+VbcT1B7nY8zt1k3e+Fr6eZGLnghKF2
         BPPDLE7WlQ2sn5OniU9KWCvk/1tZM4bvmLiYe7tRgzVuVZdHUhlYr6Cw5v5/Hllrtsz6
         sTE9CsoErPIm3nnIKbI/wIxcdQWEOHki1tr4N/frziHERB1Jf2SNNwEAGBnRdO42fXGt
         1YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=REn/6f42wu3Ujz8NL0Ob0M4V4AQhWs1dXX8RWkuqpYQ=;
        b=bMGxzDwFdLxclW+dZVf8r1m0oijczeBBp7ASG9gmVBo26WTWThyyWwLhDpjpvotkbi
         7lCRcUXvAvO0tTD6S5DiONl0lE+Asi6pyCPbmilZeN1RAKBWhrnrMfh+8aKEDjpX4rSE
         ifkZ2aLOKic0Em9r0HTa4kwADmRUxGM07+ICMWtdldJrdn6eIBdOBEQhKWbPanrDwRr7
         XKQRyd4U/+jadNp1HFgnS4S1mNJITZkIa+EddwVk8pVOBE0YRkD/7W2HJGSRirAQw+ec
         VNOCJlPrGLTijDGtG7jVUVP63ADT+uEqa1bgZvNPJvQ0LqBzaOIgAXt25lXen/21Ggv1
         JFfQ==
X-Gm-Message-State: ACrzQf1ODnj5XY+zpm9WLZOEPnUB5Wmq6qNx2gTEIX7yOPsIfNqDeAxC
	3trUc1lAPTdO8F5ZZjU6Tw==
X-Google-Smtp-Source: AMsMyM70h7MRvtWt83YSbUFafsdxf5qggWydTqiwjMQ0xzPkRDxSEcsP4vkv1rFfH7RSl46y0RI3Tw==
X-Received: by 2002:a54:4799:0:b0:354:94a9:be80 with SMTP id o25-20020a544799000000b0035494a9be80mr2870170oic.102.1665450522459;
        Mon, 10 Oct 2022 18:08:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.114.66.47])
        by smtp.gmail.com with ESMTPSA id be5-20020a056870588500b00127c03b39cesm5818820oab.35.2022.10.10.18.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:08:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
References:
 <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
Subject: Re: mptcp: set msk local address earlier: Tests Results
Message-ID: <e80c058e-76e0-b641-8a19-04cc6bab96b1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Oct 2022 01:08:40 +0000
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
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5054593733230592
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5054593733230592/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6180493640073216
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6180493640073216/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d0001ba44bcc


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
