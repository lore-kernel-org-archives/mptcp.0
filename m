Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044591840
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 11:58:53 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id r2so18306937iod.9
        for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 04:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=u7pajFUiUcWl6Ws5GmmHna6fjLCvmQgkXbxNKbzTnJU=;
        b=E2OQjAZ/ILeqqTp0ucU4mhBl3fXJ99QPXh+Bnsfcg+i3V2b4e3MsfUgFsz/fRvDfDA
         aRf1wZTptNETKpyZq0vOwpjfhMq5sUXVVRguLiffMYpXFAJ4szKhLh56wx0j2B//7ar8
         mZ2rCQ/z38NodMH/dkwwtzKyj3mM3kL6G+Q3HK9KHWTLQ5icpgUD6/+IY639AVM8ylGs
         uKa64gjMbEoJFL9QtKifLUkwSrz53FtHipQIysUJLtJT5lPYAE1LK+lLzmtzghq3VKkz
         rqnQYJQBlZSKeKlA+6bqISwsoIde5Vfh3MZ8Eb5NygMmuPjCDiTg9vcgai9i4aIJ42OE
         QXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=u7pajFUiUcWl6Ws5GmmHna6fjLCvmQgkXbxNKbzTnJU=;
        b=Y4WkVjMgQT126dv8SMtnBsF0ujfSSU+Dx0zOVFvl/s/YRMEqf0Qnv2i3yRPgWVp8KG
         OKa6fLM65KDBgMV47YqUlOJEHGdbKKpilaLBOYWRjQRzsU1AIp1eu8Gud+8w+zdvMSFB
         nAq4vedxDdeyfjIJAD/iFYfKy0ZsRcQ4xESP8dqcdtabzG8wS5+vZBTz4hDxX2HfoGJH
         bGXG85CsFkHaupVpByxauEAyvsZwOca/kKujnVull4IpVRO7t78f5FJAJaVs2ipU+Rb7
         7RP2ws4jYILc6mM9VMl3V2BHZESIfj2I3+G/WsbyPuKRS2LlS0a/qXz8dZnJ9KDIfCny
         TjFw==
X-Gm-Message-State: AOAM532ZKrc0NmEgaWci3bfomYnzxVqO97BMJfNWub6P4uWwMyx/PBMa
	uq/cwQUEh9dsU9gIn4EDHQ==
X-Google-Smtp-Source: ABdhPJwiSeCFNqghH5jB8ZMJfQskODbuNnNqbuYKfzDAPRJIKTHLOZqJ3qF/6AsAE3psEr+oKVdreQ==
X-Received: by 2002:a6b:d10c:0:b0:641:63b2:9ef8 with SMTP id l12-20020a6bd10c000000b0064163b29ef8mr13122694iob.135.1649678332182;
        Mon, 11 Apr 2022 04:58:52 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.163.164])
        by smtp.gmail.com with ESMTPSA id e203-20020a6bb5d4000000b0064dafa0416fsm5684105iof.2.2022.04.11.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:58:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <66a6c06373c3905d5b0ecf4fc082cc3750f5479b.1649672265.git.pabeni@redhat.com>
References:
 <66a6c06373c3905d5b0ecf4fc082cc3750f5479b.1649672265.git.pabeni@redhat.com>
Subject: Re: mptcp: add more offered MIBs counter.: Tests Results
Message-ID: <f6757a49-d76b-dc75-c489-0f0ed00ee462@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Apr 2022 11:58:51 +0000
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
https://cirrus-ci.com/task/6597949374332928
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6597949374332928/summary/summary.txt

- KVM Validation: debug:
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4768362025713664
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4768362025713664/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3b2bbb4557d7


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
