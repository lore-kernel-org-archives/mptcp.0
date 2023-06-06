Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D622DBD0
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 14:30:46 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-30c4775d05bso4601185f8f.2
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686061844; x=1688653844;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ganFZFDwH0y2iB/wVZU/hJTzNz61gkwHhwW94fV1tw=;
        b=6pH1hGcm90G9h9RdLNfqDYUbyj26wiB/9+075f9Bke5g3om8r9F9Ap29TFnqrpL8in
         q/cmQrQ8zVV3VbCNzp6Zb+AmIt8NBd07zNhbk41lKt0TkcIAFLFnh7GMORkPTk4wZ440
         siFoyK6Y7+G/d2m24qlBzLCNitxggAA7U6QvddlrYDow3940CBO4mkKfGLEepabvIn9y
         BPWos52xIpnkOWl3xNTpuVy+htFAPNqd7QG6+pF9UbYXBcUYiDNiDd+8AATK9ibs0F1Q
         6IO2Qj7xUAYawd+bGvad2S48v93x6z1Gfvhw6oCw7iTu2E8zh6YKXdlsfy10WfnanZFN
         ptmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061844; x=1688653844;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ganFZFDwH0y2iB/wVZU/hJTzNz61gkwHhwW94fV1tw=;
        b=Tv3Loy3Ca1ntGS3rTGledFlDs68ooIqSxDDvnKH96JMz16oUFVVTNgnndGzCvO2PSp
         pneSSuDKq0OwJ3wZ/qJocPNaAw82YArJofUCYDMuYRP+lBvADxYKI1X5g21JdNb973tA
         T3DxQhWqXS/DBWRV3ZsRdBtjOgfmwrj2ZEkFUsopBRC0NEZKDOCn1iAy8wGD+ioKoqqB
         HmBTWzfqtXjseQpS3U9WT0eMefqHGhEJGDZPPstEZP0EzZvbvyKI3DVwKZkNDix9khtA
         zTwDOXpsGdDTrm/T5molEKhe+/W2LLrzkdhIfWykxDUwUjj9gJ9ihLE4YQlZv14X0XjF
         m9IQ==
X-Gm-Message-State: AC+VfDzCpIUoGE6QgjZsvP/hS82UFFGsItFht7YFPNSxeK0tTcHBjWH6
	qD0UlWdRNU8JO4EuPTZ1hg3tIQ==
X-Google-Smtp-Source: ACHHUZ6RnROOA4+kHYbkumHme6DXEWTihBdXwoBzvBSL2v1LYRqA/DYhuquy79l1apqkhbzJJ4XjYA==
X-Received: by 2002:a5d:4712:0:b0:2f7:e3aa:677a with SMTP id y18-20020a5d4712000000b002f7e3aa677amr1742889wrq.46.1686061844183;
        Tue, 06 Jun 2023 07:30:44 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:426c:bb31:d569:3738? ([2a02:578:8593:1200:426c:bb31:d569:3738])
        by smtp.gmail.com with ESMTPSA id p6-20020a056000018600b0030aefd11892sm12747513wrx.41.2023.06.06.07.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:30:43 -0700 (PDT)
Message-ID: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
Date: Tue, 6 Jun 2023 16:30:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, MPTCP Upstream <mptcp@lists.linux.dev>,
 regressions@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: 9p: MPTCP tests regressions due to new 9p features in v6.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric and other 9p devs,

TL;DR: it looks like there is a (small?) problem with the new 9p
features you recently sent and it causes MPTCP tests to be unstable. It
is tracked there: https://github.com/multipath-tcp/mptcp_net-next/issues/400


First, thank you very much for maintaining this very useful FS!

For the MPTCP subsystem, we are running various tests. Many are ran by a
public CI [1] in a VM by using QEmu with 9p thanks to Virtme [2].
Virtme, its dependences and a script to compile the kernel and run the
tests are "packaged" in a Docker container which eases the deployment
and the reproduction of issues using the same environment [3].


Since v6.4-rc1, we noticed that our public CI was reporting various
instabilities, mainly with Packetdrill tests. Packetdrill [4] allows us
to easily call some system calls, craft and "inject" some network
packets and verify that the kernel generates the expected ones. It was
difficult to reproduce the issue but after investigations, it looks like
since v6.4-rc1, Packetdrill is slower to craft and inject packets,
causing the kernel to retransmit packets (retransmission timeout) that
are not expected and tests are then marked as failed. For more details,
a ticket [5] has been opened in our public bugs tracker.

I ran a 'git bisect' and found out that it seems to be caused by the new
9p features for 6.4:

  8e15605be8ba ("Merge tag '9p-6.4-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs")


If I revert these commits on top of our "export" branch, I can no longer
reproduce the bug:

  $ git log --oneline --reverse v6.3-rc1..21e26d5e54ab
  d9bc0d11e33b fs/9p: Consolidate file operations and add readahead and
writeback
  740b8bf87322 fs/9p: Remove unnecessary superblock flags
  8142db4f2792 fs/9p: allow disable of xattr support on mount
  46c30cb8f539 9p: Add additional debug flags and open modes
  6deffc8924b5 fs/9p: Add new mount modes
  1543b4c5071c fs/9p: remove writeback fid and fix per-file modes
  4eb3117888a9 fs/9p: Rework cache modes and add new options to
Documentation
  21e26d5e54ab fs/9p: Fix bit operation logic error

'git bisect' seems to suggest the issue is due to the first commit
d9bc0d11e33b ("fs/9p: Consolidate file operations and add readahead and
writeback").

It is not clear why these modifications are causing such issues because
the Packetdrill tests are not doing intensive read and no write on the
disk (only stdout). Not so much info has to be read from the disk: one
small Python script (255 lines [6]) launches multiple threads, each
executing the same bash script (22 lines [7]) launching the same
"packetdrill" binary (1.1 MB) in a newly created and dedicated netns.
Then each test reads a different test script of ~30 lines, e.g. [8]. I
think most of the time the problem is seen at the end of a test. From
what I see [9], Packetdrill tries to read the whole test script. This is
confirmed by quickly looking at the output of strace available on the
ticket [5].


It is unclear to me what else I can do and share with you to help fixing
this "regression". I can quite easily reproduce the issue on my side and
provide more info if needed.

Just in case you wish to reproduce it on your side using our docker
container [3], it is easy:

  $ cd [kernel source code]
  $ cat <<'EOF' > .virtme-exec-run
for z in $(seq 15); do
  run_packetdrill_one mptcp/dss || true
  grep -q "[l]ive packet payload:" "${OUTPUT_VIRTME}" && break
  rm "${RESULTS_DIR}"/*.tap; done
EOF
  $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

This will compile the kernel in ".virtme" dir with the required .config.
The VM will start and run a category of packetdrill tests 15 times. On
my side, I was able to reproduce the issue with a busy machine and
packetdrill had to run ~5 times. To stress my machine, I ran stress-ng
in parallel (outside the VM) when the tests were being executed (after
the compilation not to slow down everything), e.g. with

  nproc2=$(nproc); nproc2=$((nproc2 * 2))
  stress-ng --cpu "${nproc2}" --io "${nproc2}" --vm "${nproc2}" \
            --vm-bytes 1G --timeout 60m


I hope you don't mind if I cc the regression ML: this is probably not an
important regression but I would not have guessed the issues we had when
running network tests were due to 9p, this report might help others with
similar issues :)

#regzbot introduced: d9bc0d11e33b


Cheers,
Matt

[1] https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net
[2] https://github.com/amluto/virtme
[3] https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
[4] https://github.com/google/packetdrill/
[5] https://github.com/multipath-tcp/mptcp_net-next/issues/400
[6]
https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/packetdrill/run_all.py
[7]
https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/packetdrill/in_netns.sh
[8]
https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/dss/mpc_with_data_client.pkt
[9]
https://github.com/google/packetdrill/blob/master/gtests/net/packetdrill/parser.y#L168
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
