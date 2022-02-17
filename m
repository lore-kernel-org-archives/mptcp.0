Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567561FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 17:43:46 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id o24so10361582wro.3
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 09:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5tG0kq+jBCjRkFL1RcocN3GuW2th3NRpkjRY+OgFd4=;
        b=2gxkauN/HP5l9q/kAJL4xoS6oewlM8+v7/TVyEeZTaPuoyuLFDhjgyaNWau6aZQ/Uy
         g4Nb8eHSwB5Iz5nlAlmB7CHW4c7DgqNxEFUHizzxfkitue1B+qWWokxwCEWPE8SrlZ6+
         wfOj91ksEuNhEdadtKoe7Ku2e9gCerbDfdlltDoYam2YDUhTJeNFH0it620g25FmGG4H
         0bLxJjsWyYFPJ2R8v+BDmm2uTdkXjCnkEXwQunX2LZ17PNiQgPYCn07MQ/9WkUg+Zmo4
         wO/naXKAj6fy1vhVK6GyXU3maT+jltnUu8AfWI3ikpCtNTjmA55j/zTz6kzLUM3eksQN
         P64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5tG0kq+jBCjRkFL1RcocN3GuW2th3NRpkjRY+OgFd4=;
        b=2crPDmFz4DkwcXLtST6uByXszsyHhIj44X3RSrpjvlrjzqzDkDfAOqR4HZSWI8fJIW
         5+Elt54oADIhWsLoNIgN1j2Gxk+yPMaLfmdvHSbcXGU+LZ/ZcgxK23hlxBi/jQMxyP5d
         acl/MQkSJuDmmMUa3brOUedHyLwPQjvPeM24FMPkyYJEPH+SLQEow/YDKnOY5nlExzpE
         lhKkuWUqUVEeGECTu16/F7zAALzwEd4NXt1Baq/qUFhDIvvNrIiKLnWxa3p/RzhA18Fp
         FGVB3OnY1Iwx0zBYWxdT2nhJb28X1JQxI08nuXRzHpTGqdBz5TzhsZDYbXfsEv9OgyGu
         flzQ==
X-Gm-Message-State: AOAM533rwHmvdhwPGX3zXz2pIeCg9VvupVEcxnKuqPC7VcpoqC8pbhqi
	dcrwNWXPH+FG02LjimN0TItFVJmnhlWJQA==
X-Google-Smtp-Source: ABdhPJxhd6N6KPbBTny0U5eZBiLQN0k6dD50Em69wPvGZLfDWlVUU7XNVqDR3mri30PZjELsCQhRTA==
X-Received: by 2002:a5d:59a8:0:b0:1e8:ec93:d757 with SMTP id p8-20020a5d59a8000000b001e8ec93d757mr2336922wrr.128.1645119824996;
        Thu, 17 Feb 2022 09:43:44 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm23060203wrb.43.2022.02.17.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:43:44 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 0/9] Refactor mptcp_join.sh
Date: Thu, 17 Feb 2022 18:43:20 +0100
Message-Id: <20220217174329.826430-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few patches from the v1 have already been applied.

Compared to the v1, this series comes with new patches and updated ones.

Patch 1/9 was suggested by Paolo: bigger than the original one but following the
standard way of using getopt. This is also clearer and avoid regexes.

Patch 2/9: while working on patch 1/9, I was annoyed by having the tests groups
defined multiple times. And I think it already happened to have missed the
update of one of them :)

Patch 3/9 is "safer" but also needed with the new options to execute specific
tests.

Patch 4/9 is the updated version of the previous patch 3/9 from v1: mainly
rebased. I only added one line in the "usage()" function and use lower cases for
only_tests variable.

Patch 5/9 is new and similar to the previous patch: another way to execute a
specific test, useful when using 'git blame'. Also help to have patch 6/9.

Patch 6/9 is a handy feature when trying to find which tests had issues when
executed on a CI or locally.

Patch 7/9 was present in the v1. Non local variables have no longer been renamed
+ a there were a few missing 'local' keywords.

Patch 8/9 and 9/9 are the same as in v1 but rebased. We are still ShellCheck
compliant.

Matthieu Baerts (9):
  Squash to "selftests: mptcp: join: allow running -cCi"
  selftests: mptcp: join: define tests groups once
  selftests: mptcp: join: reset failing links
  selftests: mptcp: join: option to execute specific tests
  selftests: mptcp: join: alt. to exec specific tests
  selftests: mptcp: join: list failure at the end
  selftests: mptcp: join: clarify local/global vars
  selftests: mptcp: join: avoid backquotes
  selftests: mptcp: join: make it shellcheck compliant

 .../testing/selftests/net/mptcp/mptcp_join.sh | 2248 +++++++++--------
 1 file changed, 1202 insertions(+), 1046 deletions(-)

-- 
2.34.1

