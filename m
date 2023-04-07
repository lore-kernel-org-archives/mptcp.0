Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351E538B
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 14:16:03 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id kq3so40066986plb.13
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680876963; x=1683468963;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAQsvjRNdiLAiaswzSRNqlojCsDGlkAf3yWQFDjS5P4=;
        b=b0UB1NIKmUhnVf4ySwpEIJ2jYFO3+XAJYrRob0qwN/WJIcg2Y87On+7PcHKrppCH0k
         FnoKui1wj9JcI9XXPtdDYQHe2IuVsa0rPtpnv4uWqnKA1AoHzNb/DO+sk7oX2/dJGrME
         u5sXi6oX4sLkNKq1XYbEMwVeeetLXQSTJBm0z2ice5PK3DYjBwy3qcJm46JcO+FCe2WD
         rVMaN11zqXlEi+1ChWqxuGcMnYFM47Oxrz8hi9A6gzWCbnTaXsRXmXz6kPn6LIMP3Rnz
         0U4fqUODm6s6udx9pq12vpkexuibNjCRBUJNaxSzAAjHpK4lzNIO+2P3gncuudqk7QsJ
         ZCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680876963; x=1683468963;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HAQsvjRNdiLAiaswzSRNqlojCsDGlkAf3yWQFDjS5P4=;
        b=ayJR5B/K/axELN/WA83KwTYiFcXqSQFmjV1p4B3rrGNn0siKmqkr1OkBksZos1PtT9
         8K9jUj2V575iRLSygGvo/fWSlr4NgPsBkNRMtICMj3Ppt9XrqQ6dhrNl5oO8gGPOJTGa
         y3j3+vSRqQ/ybMdcV0PGNUY2QZnq6PXZ0BiA7w5h45DbOE1fnjNTMnLhgpfwe5abck/2
         dkRSqtOdqBCtoJgjANw922sB8E/POPhiTVTK+yfmKFS/3c1rkFxbyxpY2i6l9ktaVs+0
         zJZgPbN4Js218A+OmLSuLx5C4982xbniqqyM1yGne3UD/ngMC+ayVLM87OvGlLBwz62O
         O8ng==
X-Gm-Message-State: AAQBX9dMQDBVSiKLqDASytrOIhAf2lPypao7+JhtQD437ga5G5cF7qIX
	6uw4qUnSGgVIu7fC2xNZ8jHz0pyLiU5Z
X-Google-Smtp-Source: AKy350b21prZJLncw/2nJMNi5qjKpaZIQYE2Lfn9TWwcP5dcB0EvGA5NYqB90RrP+xBZTqAPUTIYpw==
X-Received: by 2002:a17:902:f143:b0:1a5:3da:84cb with SMTP id d3-20020a170902f14300b001a503da84cbmr2404587plb.21.1680876962676;
        Fri, 07 Apr 2023 07:16:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.13.80])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902a50500b0019ac23cb6edsm2482867plq.181.2023.04.07.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 07:16:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230329-mptcp-misc-cleanups-v1-3-a839001f0b05@tessares.net>
References: <20230329-mptcp-misc-cleanups-v1-3-a839001f0b05@tessares.net>
Subject: Re: selftests: mptcp: remove duplicated entries in usage: Tests
 Results
Message-ID: <f2a553a8-687c-c219-3570-66c8c4e5b848@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2023 14:16:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5918299830091776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5918299830091776/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4651662434893824
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4651662434893824/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6481249783513088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6481249783513088/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5355349876670464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5355349876670464/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a5422f94b9f4


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
