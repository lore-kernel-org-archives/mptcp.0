Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218542115
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 19:28:23 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id e22so7407110qts.1
        for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 11:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sMS5HLkFhLJu83iTbG5qtSqle8fyov1Do+3PgIHBbc=;
        b=Ny3ERyGee8kX+QhQPMQMAqijFqVDi20FcoXNJXbBkkhvQ4lV7FkTG5ntKwaJhtjQ0m
         bDLTkhGbLIq1ulZ8Hu3Eh4YQHWtCX1hYMmrI2S+cvRgHDFisrX5ECtINtGrgGkiFyKWN
         k6yKdxz/qz9lOeblWWxMIGnIRLR4xl+M5WKzSRDaOvdXnTLMzg3sdljrvzP/w7m2Bvhq
         VXGV36QM8AKQTvOJuaMw7hHZBekQnjCDA1rBGLFqgG6HYKkQ7INRiso4i7NLRRPmtGI5
         OauK6FWAXQxtymTtqG4aHO/ChpxnEzpN8KEDhccR9OJAYohlBZjc97duKNUadRZfgCtA
         x/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6sMS5HLkFhLJu83iTbG5qtSqle8fyov1Do+3PgIHBbc=;
        b=IIARcXchugogMgFD4jVFYYI9ezGk7niE775lQot5tld8s2P7RoFogNwH7GwRBKEyKB
         YgxEKAl+8qMkQFXXxriVuAYwzYk/svCrHDi+jn1EZMP4xZkYr0rfDDjIOhuUxIFJA6bz
         h6srw35IXhAo3SnPXncjM+7NS5YQVtlJ8JEZmO5T+5WdjqsjUKQpE+9kST3OEhnHqQK+
         KISSGedp1OqfVkf5Ltrl1B9iVcCIS/freQNJV80xYZY/PVmB8wjyNSjv5JbGoBbJrBU4
         oa8uGItox3HmwIV3YJJ9/p9f4vbCMJvztA6AkEM2akA2FAASHJoDxH7fd1AUg3n68aVA
         AaIA==
X-Gm-Message-State: AFqh2koi/k8nvll3Ac8+lcuv+/wB6klAm2e6ec4j7MtG6CqpxedmEisk
	J6MPQBpjxC7i97KkR7r+RQ==
X-Google-Smtp-Source: AMrXdXsjDL4qhojjcOdjHxMLA6YoEhqtgr9b6sSh7jwXN5QHWhl5NA1d8tSyCvu2D/pJWfoHkG6rCQ==
X-Received: by 2002:ac8:4a88:0:b0:3a8:15e2:a068 with SMTP id l8-20020ac84a88000000b003a815e2a068mr110971074qtq.4.1673638101972;
        Fri, 13 Jan 2023 11:28:21 -0800 (PST)
Received: from [127.0.0.1] ([172.177.22.51])
        by smtp.gmail.com with ESMTPSA id w6-20020a05620a424600b00705be892191sm8734011qko.56.2023.01.13.11.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:28:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b20fb19052027c1e2b2455e852537ebd068c78cf.1673629755.git.pabeni@redhat.com>
References:
 <b20fb19052027c1e2b2455e852537ebd068c78cf.1673629755.git.pabeni@redhat.com>
Subject: Re: mptcp: refactor mptcp_stream_accept(): Tests Results
Message-ID: <7d86fb69-3c24-4ae2-8095-29af356c7251@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2023 19:28:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5237060924080128
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5237060924080128/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_syscalls selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4955585947369472
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4955585947369472/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6362960830922752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6362960830922752/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6081485854212096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6081485854212096/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/039d0617a717


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
