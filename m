Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBC3FC2
	for <mptcp@lists.linux.dev>; Thu, 26 Aug 2021 18:35:06 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id n27so8368081eja.5
        for <mptcp@lists.linux.dev>; Thu, 26 Aug 2021 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1kFbVEEvpuovHyzTVvE+d4dz0sdm8CaQwqzAVIY5hI0=;
        b=lnPLnREuuu1RjopLQfnO3LJCA1TzbaIRtpBMbrum33cNa0FUqeBCRaKSXfX+ZJSUlc
         FpX9i0rMUiAxICC6UpiipQT1tIek0I83jWTztO5swUlN0K8IMrzaqXW0I7ZA0hEbf+j5
         9sXg8SHoEly8PiheyHBO0zTRYoVBBlUhieevshYs3ycSaXWCV6sN3XSlEKaltp+PTtId
         xdg5zy4qKfdSitBQNUCP/hwGujsf3BByQwsE0oRlEw+ryUkmgkUSUC28vMW/vVxHQ+Kn
         nQQ2Am6Lrxr0Jw27qA5NiyCpPOfDbkSGZuq6kF/2rWOLG8MyoRG3YEyKkGTG0hzcR0Cu
         j2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1kFbVEEvpuovHyzTVvE+d4dz0sdm8CaQwqzAVIY5hI0=;
        b=N9c0Uhw9bFEmowkGN2b6/IHf43vDY7sYcP/u3BPggOAIvbq5CnKBhE0CwrRhuzfmiu
         o98oR7HfxAkbvlWjw0jMv6gbl7fYd4QtQYABUMi3Sy0GSn+IaZd75+p95MenJ5frteGA
         do52ZHds9YdDkCQSNPp2eAbPm5XPTNQ32eatBd3b+fPGpS/vqjVDacuJHte2LgvpXjTv
         KFFm7207J0dMtZTKZ+tQ2RO8ssLxk5O6faD7AfiMSw+XsrS6DzseQZD9dxHn2JcyqNpW
         7t3Ps5YKxrQBCXLNj0KRPM4MNeDLtseFQhph+mdm9Oxs3E0VJ4SE9uPEjNj7sban2bMh
         8HEQ==
X-Gm-Message-State: AOAM530zfK1e53wCcG1a9EMwBo4P7zZwrwRov8B7mhKrAsBIr5OwPR7K
	O+TetaMNk9G2Q0EQ9ZDuh8op9ls2oVQYt/JD
X-Google-Smtp-Source: ABdhPJwD12Ld/SfflTj1jcRUqjRLnEzyr0jN12RuNu+cZlwTRmO8rqQr9jiQcTvIZ4RIvOVH4whXiQ==
X-Received: by 2002:a17:906:ff41:: with SMTP id zo1mr5471883ejb.525.1630002904303;
        Thu, 26 Aug 2021 11:35:04 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id z8sm1746031ejd.94.2021.08.26.11.35.03
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:35:03 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] MoM - 26th of August 2021
Message-ID: <4723f4cc-c9f8-26c6-9f26-35f6c2ef2975@tessares.net>
Date: Thu, 26 Aug 2021 20:35:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everyone,

Last Thursday, we had our 162nd meeting with Mat (Intel), Christoph
(Apple), Florian, Paolo, Davide, Poorva (RedHat), Geliang (Xiaomi) and
myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Mat Martineau):

12456077  [net-next,7/7] selftests: mptcp: add MP_FAIL mibs check
12456075  [net-next,6/7] mptcp: add the mibs for MP_FAIL
12456073  [net-next,5/7] mptcp: send out MP_FAIL when data checksum fails
12456071  [net-next,4/7] mptcp: MP_FAIL suboption receiving
12456069  [net-next,3/7] mptcp: MP_FAIL suboption sending
12456065  [net-next,2/7] mptcp: shrink mptcp_out_options struct
12456067  [net-next,1/7] mptcp: optimize out option generation

12453781  [net-next,6/6] selftests: mptcp: add_addr and echo race test
12453779  [net-next,5/6] mptcp: remove MPTCP_ADD_ADDR_IPV6 and
MPTCP_ADD_ADDR_P...
12453775  [net-next,4/6] mptcp: build ADD_ADDR/echo-ADD_ADDR option
according p...
12453773  [net-next,3/6] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
addr_signa...
12453771  [net-next,2/6] mptcp: make MPTCP_ADD_ADDR_SIGNAL and
MPTCP_ADD_ADDR_E...
12453777  [net-next,1/6] mptcp: move drop_other_suboptions check under
pm lock


    our repo (by: Florian Westphal, Matthieu Baerts, Paolo Abeni):

12454197  [mptcp-net] selftests: mptcp: clean tmp files in simult_flows

12450095  [2/2] mptcp: make the locking tx schema more readable
12450093  [1/2] mptcp: fix possible divide by zero
12454335  [mptcp-net] Squash-to: "mptcp: fix possible divide by zero"

12447551  [v2,mptcp-next,4/4] mptcp: optimize the input options processing.
12447547  [v2,mptcp-next,3/4] mptcp: consolidate in_opt sub-options
fields in a...
12447545  [v2,mptcp-next,2/4] mptcp: better binary layout for
mptcp_options_rec...
12447543  [v2,mptcp-next,1/4] mptcp: do not set unconditionally
csum_reqd on in...

12447541  [mptcp-next] Squash to "selftests: mptcp: add mptcp getsockopt
test c...
12447175  selftest: wait before trasnmitting first data chunk



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Jiang Biao):

12454073: Rejected: ipv4/mptcp: fix divide error:
    - Paolo made a patch fixing the root cause of this.
    - Mat asked Jiang to check if this patch fixes his issue on his side


    our repo (by: Jiapeng Chong, Mat Martineau, Matthieu Baerts):

12282219: RFC: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to
tcp.h/mptcp.h
12282221: RFC: [RESEND,RFC,4/4] tcp: parse tcp options contained in
reset packets:
    - WIP

12282223: RFC: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
    - WIP

12282225: RFC: [RESEND,1/5] tcp: make two mptcp helpers available to tcp
stack
12282227: RFC: [RESEND,5/5] mptcp: send fastclose if userspace closes
socket with unread data:
    - WIP

12321111: Changes Requested: mptcp: Remove redundant assignment to
remaining:
    - TODO

12458723: New: [mptcp-net] mptcp: Only send extra TCP acks in eligible
socket states:
    - Issue found by syzkaller
    - The patch fixes an issue but we cannot be 100% it is fixing the
one found by syzkaller
    - The patch can be sent, Mat can pick the tag/from.
    - The subflow has just been created, SYN is out but not in a state
to send a TCP ACK.
    - → can be applied: TODO Matth → Done



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 226)

  229  [syzkaller] divide error in __tcp_select_window - path manager
[bug] @mjmartineau:
      - Should be fixed thanks to Paolo's patch: mptcp: Only send extra
TCP acks in eligible socket states


    Bugs (opened, flagged as "bug" and assigned)

  229  [syzkaller] divide error in __tcp_select_window - path manager
[bug] @mjmartineau:
      - see above

  226  selftests: `mptcp_join.sh -l`: copyfd_io_poll: poll timed out
error [bug] [selftests] @fw-strlen:
      - Florian and Paolo shared patches there
      - discussions will continue after the meeting


    Bugs (opened and flagged as "bug" and not assigned)

  225  selftests: join: "remove subflows and signal" is unstable [bug]
[selftests]
  203  PM: server: accept subflows [bug]
  181  implement data_fin ack retransmission for subflow in  TIME_WAIT
state [bug]
  137  selftests: simult_flows.sh: unbalanced bwidth tests are unstable
[bug]
   65  packetdrill/fixes: clearing properly the status in
listen()/disconnect [bug]


    In Progress (opened, new feature and assigned)

  216  The infinite mapping support [enhancement] @geliangtang
  194  Round-robin packet scheduler support [enhancement] @geliangtang
  186  Add netlink command support [enhancement] @mjmartineau
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
  158  iproute2: change backup mode (MP_PRIO) for active connections
[enhancement] [iproute2] @dcaratti


    For later (opened and not assigned assigned)

  224  support for `setsockopt(TCP_INQ)` [enhancement]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  220  support for setsockopt(SOL_IP) [enhancement]
  217  Support `IP_TRANSPARENT` [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  210  Accept new subflows when the listening socket is closed or bind
to one IP? [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  171  iproute2: support removing ID 0 [enhancement] [iproute2]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
  163  allow ss dumping msk socket in TCP_LISTEN status [enhancement]
  150  remove completely workqueue usage [enhancement]
  141  avoid acquiring mptcp_data_lock() twice in the receive path
[enhancement]
  133  PM: Closing the MPTCP connection when last subflow is not the
initial one and its IP address is removed [enhancement]
  128  When the last subflow is closed without DATA_FIN and msk
Established, close msk (after a timeout) [enhancement]
   79  allow 'force to MPTCP' mode: BPF [enhancement]
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   77  [gs]etsockopt: forward to new/existing SF [enhancement]
   76  [gs]etsockopt per subflow: BPF [enhancement]
   75  BPF: packet scheduler [enhancement]
   74  BPF: path manager [enhancement]
   61  move msk clone after ctx creation [enhancement]
   59  TFO support [enhancement]
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]
   48  MP_FASTCLOSE support (send part remaining) [enhancement]
   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag
interface [enhancement] [syzkaller]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]
   18  allow 'force to MPTCP' mode: sysctl [enhancement]


    Recently closed (since last week)

  228  dmesg giving wrong output regarding MPTCP [question] @matttbe
  227  selftests: `simult_flows`: hit `WARN_ON_ONCE(!mpext)` [bug] @pabeni
  219  [syzkaller] divide error in tcp_write_xmit [bug] [syzkaller]
  209  Quicker use of backup subflows [enhancement]
  190  Wireshark doesn't understand MP_CAPABLE C flag [enhancement]
@RuiCunhaM
   42  remove unneeded branches in critical path [enhancement] @pabeni



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.15):
https://github.com/multipath-tcp/mptcp_net-next/projects/10
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    → https://github.com/multipath-tcp/mptcp_net-next/commits/export
    - net:
        - mptcp: fix possible divide by zero:
            - might be good to have feedback from syzkaller
            - and the guy from Tencent
            - We can send it tomorrow if we don't have negative feedback
        - selftests: mptcp: clean tmp files in simult_flows:
            - can be sent with the other one
        - mptcp: Only send extra TCP acks in eligible socket states:
            - still need to wait

    - net-next:
        - MPTCP_INFO:
            - better to send with the next version to have more time to
fix exposed UAPI (not at the end of a release cycle)
        - optimise incoming opt:
            - it doesn't change any API visual aspect so it should be
fine to send it now (or wait if we prefer)



Extra tests:
    - news about Syzkaller? (Mat & Christoph):
        - detected some stuff about "divide by zero" bugs but without repro
        - running again with latest patch to see if it hits anything again
    - news about interop with mptcp.org? (Christoph):
        - Running tests at Tessares on top of mptcp_v0.96 branch

    - news about Intel's kbuild? (Mat):
        - Still running and not finding anything so far
        - Intel CI is also using our GH Actions :)
          https://github.com/0day-ci/linux/runs/3427955088
          (because they use Github, a tag and on top of our export branch)

    - packetdrill (Davide):
        - /

    - Patchew (Davide):
        - Davide managed to login, start the config and import patches
        - will continue to look at the automation
        - We need a logo!

    - CI (Matth):
        - /


PGP Key verification:
    - Matth: F6B7824F4269A073 ; FP: 4269 A073
    - Mat: 142AECC9A1677277 ; FP: A167 7277
    - FW: 7091A8D9AD5FF600 ; FP: AD5F F600?
    - Idea would be for Matth to have kernel.org access as a backup for Mat.



Next meeting:
    - On Thursday, the 2nd of September.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210902



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
