Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984B3C02
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 20:03:54 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-101ec2d6087so13386582fac.3
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=aJiJOS3nvXNS9gN6bUddgkRsUkBeV3gbN9+Cqbd49VU=;
        b=K0m0A55tw6hzNroRjph3oFbeOuae2u16fVGWhI5qfKTtqv6K6/KrRj3t9uRLMqBSFU
         1Kavoe3K4W4LnzVslwWmXEpzbxK+57M8Ld7YCQ0ijBwxk4kgGsfxMxQ9fZCOdNMNyaqd
         gz2o6LRWSiIDxgT72F5gIgsuL1Bzjvh7uLeDkg5k5pezdGpe6myt7raN9dwBlA5skTC7
         1PataZHsmbRt7yYUknZVuzVzFKniL+18i5uJMJ/vq5i3tq8s6ohy3LwwDNgwNxm8Ajhh
         zIZFFkuFWvg6iSoyBXeslH0lYjdbYGCUsNgDwJm10op6AfW0Kc0UufV/5vbN4oE+3VvP
         wjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=aJiJOS3nvXNS9gN6bUddgkRsUkBeV3gbN9+Cqbd49VU=;
        b=hhO9YJV9i5NO/9xvz8e7XGe4EkWuhbgPisg88RnZ3xgb8Q2K7gNvH5jJaN3rLfqX/e
         gb+XTwt7NQ2Y7SQNTZrVrhV2q3KvgyJ8W3ROpXf61/Y4S57ohTA8PQNS2aWvQKjsKZdm
         MZgTGSESN3s0yrkRrC35hQVKj8oXFd6DGrF+Duu1NETisiwzLDEWzASf1S4JtBFOwXiB
         Mf86k13DiqeZXM4b6DVnuc/h+22rZAp8fiQf0LaECb3fhiCCMVG0E+I4ZsohCH5gkuIL
         vfDbzxsE4TPYQ+2nPcdt5wZCmk+tfjZ72lOg0+YIeeozi3OBFFaZpbYFOnyiwwtWi1ay
         c3xA==
X-Gm-Message-State: AJIora9kHiYP/MNj1DrzYXJJqEx0R999dNkG1TGZfY2CU2Rgm2fWtXwr
	WZiuBj0BkqSEnpDEmmStuQ==
X-Google-Smtp-Source: AGRyM1vcUVA/3Eo7y6BCCEN17OzK4Y4/mtNzb3WyLhz+GlNLgGya5L2BNJIpLOaHemWn23rh/h7EfA==
X-Received: by 2002:a05:6870:a782:b0:fe:23b6:6efc with SMTP id x2-20020a056870a78200b000fe23b66efcmr70157oao.66.1655928233576;
        Wed, 22 Jun 2022 13:03:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.234.13])
        by smtp.gmail.com with ESMTPSA id t17-20020a9d7291000000b0060c29c6d7f6sm32665otj.32.2022.06.22.13.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 13:03:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220622175547.289717-3-kishen.maloor@intel.com>
References: <20220622175547.289717-3-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: userspace PM support for MP_PRIO signals:
 Tests Results
Message-ID: <6ad8981a-7713-036b-d9aa-e1843aaa11e2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jun 2022 20:03:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5802668730875904
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5802668730875904/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5239718777454592
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5239718777454592/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/290f28914c4e


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
