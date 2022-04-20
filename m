Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57410F3
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 01:02:52 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id f22so3998qtp.13
        for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 18:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=UhAJt3Vsn8hnfiIlB76wkeGKgKKSF+xHOpUT2TDVQuY=;
        b=SSpgKHGjHCcWMrmCyI0dPTjn9EJdY0gpD8riMER0XHnWmAjgfCRcssbLbvELiljO2/
         cet8YKzp6Q0ZxyKBoBRTU23mfeqJuHjKL23GTgNmdupcXTxSSLqaGd+WaN9u2RLB+jru
         /lqHYNlu6IH9GVo/cCF+DULl2P6rpRlt0mN0liuApGVzuj3GMlXTc9Y6m/RydDB7P0jY
         xWXoeSz0+uGBfcrFZ3dvtDI+uyuLdlGA3J+UhSlRpc5Qsyg8f4pROW14ZLt438Bvpvfr
         QYmnXWykpvoWhmPvwzQRVmD0KlY/SozE34gUInV5aKuoge0KW8/0OGBHt09yU0Mkn7HT
         Hqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=UhAJt3Vsn8hnfiIlB76wkeGKgKKSF+xHOpUT2TDVQuY=;
        b=BnAfP8IxSgi1SfSmffLr3cGTKpY5+PqVPVVJpC3hpaD0WwR0tGAvvOhQ53oGEL8qwT
         vAC6sRtXLCfxIqujZ71l8l2C3aAO2WPjYOExCS2/qfIIZcaVZRTBG5G2CS2Z8QyMsYY+
         WUO7kML7zUGQTnxQ59+xNuUgpy9a/1nv1i1T+g3To5QDa0VDesG0+ic/jKg0vDYMLcwu
         OGt28KX9G/liS2S1kfhSCpnYdKa3Y86slah2+Q5BKFbdiHEN3VSw0k0UitXuM3Jr+ZHp
         WBFl820iJJitnlXgLbgP9u/n+LwqH17bc8YWWtq66Gsb+xdGlcszi/x86NrsQPfTboFw
         H6OQ==
X-Gm-Message-State: AOAM5335vdEikNf2WiGKaCKpFdVnMK2JH078FHgJHtS+GIOHi3yRhWJA
	oqY6E30+uDi0cMTmKhRhIjqiO1FYxQ==
X-Google-Smtp-Source: ABdhPJz0lWW9D19geT++lz/3r/HFM8aEFPFMdpr+fN50Q25GD97UxQiLoUnF//8LwulMgqNQ/I64Bw==
X-Received: by 2002:a05:622a:118b:b0:2f2:163:d2da with SMTP id m11-20020a05622a118b00b002f20163d2damr7520523qtk.677.1650416571167;
        Tue, 19 Apr 2022 18:02:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.232.106.244])
        by smtp.gmail.com with ESMTPSA id i19-20020ac85c13000000b002f33d140da9sm1043622qti.20.2022.04.19.18.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 18:02:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220419230340.2263545-4-kishen.maloor@intel.com>
References: <20220419230340.2263545-4-kishen.maloor@intel.com>
Subject: Re: Squash-to: mptcp: netlink: allow userspace-driven subflow
 establishment: Tests Results
Message-ID: <4341a22d-cf25-657a-7d27-0b1a4009de1f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Apr 2022 01:02:50 +0000
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
https://cirrus-ci.com/task/5545811772702720
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5545811772702720/summary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/6671711679545344
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6671711679545344/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b0d39b257105


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
