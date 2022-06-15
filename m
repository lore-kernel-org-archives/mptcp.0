Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DA3FDF
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 22:10:24 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id bf7so16014812oib.11
        for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=3Enqe9iXrltOH/HXrAo79ZtZ/g0LHSI0ZmRQF1hvXj4=;
        b=i8msop+n50b5zi9oV0nlQxWakvg1xNVP7GwDb1Q5OGNlhHxRb/DH/ezBiIl/wqjJlg
         ZuuhcwGjfl9Vo0wd8HaRmIY3U37wI/jdGYpSjZMk0bp4QKFDpOC/6smouF8Mk9nImHmm
         uVdby9BE1GL/2ioYxdTtctFnhZIr+zSOPDo96+LZhpQtBmpcr4vdHAvC+6+wDQj+808u
         7tNdZ3k1szMQdxabxZXh3kbaWGzG4p/uOfpnR+PSMZZjmeYrHgbWHNgiTEWfleTHC0ZH
         SHQ1ixxHiJ3nFdmEUTstZQKdN/3kqc6/p8wUY+/Ap1+n9TXjBJ0P2ytlUgfVapm0EiBW
         5/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=3Enqe9iXrltOH/HXrAo79ZtZ/g0LHSI0ZmRQF1hvXj4=;
        b=MjyRZDqeJgCBxy2ycT9GOxDefw7SiMagMtU9aJ/zKViApNTnp6rDgRU+INCsTzAOC9
         ARtzRT39/b6s36304yWQa/8CcmI0uAZT6Vfs8Yi7w/rn7v34jBqWgG6gZY9uf0x0n3at
         kMrXX2f/p00YyKTva0Oo4tn67YjiuJ4eyXEVqloAEIczQEl/lrjarrUT1worrkvgpTzE
         5QUQAIVKxzGs7Halqea1HnGsBffmORMbWTuegHQE9LvMCCexxqTikHe/LEllK1L4wnFl
         lHKtdL5gMXi83guuxCOsBHYDohx54PbblmZJMmDO7kiNIPi88m3FG14eLBA5oHnEFUQm
         xomQ==
X-Gm-Message-State: AOAM533srvokHV3GHBX9d0TbtoQflWPC17VTQqTzzNUtMSUc5PIn7/YH
	PhoIazenkVnbLgRpjbo2og==
X-Google-Smtp-Source: ABdhPJzdahGOR+sm18DqgWtLSL0hkwqQ2TNpwZYRMMakXAmokH+FLIpiA/XygoPOfyeulI3fjB+JSA==
X-Received: by 2002:a05:6808:23d2:b0:32f:1a3a:2212 with SMTP id bq18-20020a05680823d200b0032f1a3a2212mr6412496oib.178.1655331023196;
        Wed, 15 Jun 2022 15:10:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.85.15.215])
        by smtp.gmail.com with ESMTPSA id w128-20020a4a5d86000000b0041e992e002bsm158026ooa.38.2022.06.15.15.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:10:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a87184583103c8dd66dc9e314ccb99d3daadc00e.1655324843.git.pabeni@redhat.com>
References:
 <a87184583103c8dd66dc9e314ccb99d3daadc00e.1655324843.git.pabeni@redhat.com>
Subject: Re: mptcp: fix race on unaccepted mptcp sockets: Tests Results
Message-ID: <4ead90bb-c474-faee-2ce9-470679c09426@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jun 2022 22:10:22 +0000
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
https://cirrus-ci.com/task/5240636109488128
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5240636109488128/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6366536016330752
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6366536016330752/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bac04f5bed54


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
