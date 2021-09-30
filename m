Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139B72
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 16:40:36 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id ba1so24514683edb.4
        for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uE3g6WKpznpShhOshaCf3g9Vf5jGprxuL6bIl401Lus=;
        b=xEEhwt+CF3xVyrTm6Z/SS/pRn0pmCGk/ti8UQAPmci8z8PdLVIM/05oTUzWJ7NorV4
         vT2I6zqR09onQsj64ocpWU2lXPH05j1Uj+7UzeN78nYaZscaHCfOMOnoyhUrhTQq+y0d
         M/Qg8BnpsHXFVRaYUCjKu/OulQXzejmFeL7WKYYgE27FiG5FT+0Yx6XTeXLKt/2svZGM
         bzEEA99gjjdm0O/sdxp2Ctn1ZRzQk8Q+i1E3+KrLDILuhkjyo8q+uth4fdhPJ74Bn8Rs
         tLPQ2lmpykJTlhRcfeDynxJ24cMdQT0hG5zq//xz/HTAPDWGY8e9VPxjiSn9dkrz1mci
         pxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uE3g6WKpznpShhOshaCf3g9Vf5jGprxuL6bIl401Lus=;
        b=v2OIN9l8Q4FsEhv7YiCnlhALR7UoJCNNu1EUb1/eA1ArLOO7dN0j8OwBeKcyS5ScJP
         2ji4WSWK7N1JpBv6rZM7yj5jVqDHzqdtFLVhrXrJrDuWKJhGVKQUmaZUJK75P6YaNTVG
         3UFJL0LmBkgJXVaF2S4BoIMomOqIeGCLWsyM+zGrcSVa5PGYUmWhjOcKJoybypLM2YV/
         nCRqS5srZIKRSPDwNkNtAIyiwNzGsV7XrHlUqUJWp88XIN2bQHZdJd1klzyCcu7vNGbP
         Yv9zgpRh/WE0Rg8G+Tpj+PGe9PDmQe3FsQz/VEQv/LHklrQZ1qMvDO//7AW05uNUa/xw
         3VUA==
X-Gm-Message-State: AOAM5338QIS3j2wmydwUNmoFk14fMpROgfm3EQs770Nvk7BEok8Q2A2g
	yCTLheiugnq/YqOceFgnazMONcxHWk7Mnw==
X-Google-Smtp-Source: ABdhPJzrehfA7Q6B9lpUHvuFAbwTys4vmOdOS5FufJAkEaL36SF1wJBZWjB3/TOXQo73CQNxVnEmnA==
X-Received: by 2002:aa7:df9a:: with SMTP id b26mr8222084edy.368.1633020033923;
        Thu, 30 Sep 2021 09:40:33 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id u18sm1742734ejc.26.2021.09.30.09.40.33
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 09:40:33 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 16th of September 2021
Message-ID: <1fa486ab-6b90-0b57-e425-5917937ea585@tessares.net>
Date: Thu, 30 Sep 2021 18:40:32 +0200
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

Last Thursday, we had our 165th meeting with Mat, Ossama, Kishen
(Intel), Florian, Paolo, Davide, Poorva (Red Hat) and myself (Tessares).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Kishen:
    - From Mat & Ossama's team
    - TODO: Matth: add Kishen to the Calendar event
    - I need Kishen's email address



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Florian Westphal, Paolo Abeni):

12482695  [mptcp-next] chtls: rename skb_entail() to chtls_skb_entail()

12476963  [mptcp-next,v2,2/2] mptcp: re-arm retransmit timer if data is
pending
12476961  [mptcp-next,v2,1/2] mptcp: remove tx_pending_data

12476737  [mptcp-next] Squash-to: "mptcp: stop relying on tcp_tx_skb_cache"



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*

    netdev (if mptcp ML is in cc) (by: /):

/


    our repo (by: Florian Westphal, Geliang Tang, Jiapeng Chong,
Matthieu Baerts, Paolo Abeni):

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

12476757: Changes Requested: [RFC] selftests: mptcp: tune timeout and
delay for simult_flows cases:
    - Some modifications needed in the selftests
    - But maybe also in the scheduler side
    - with Paolo's modifications, selftests are faster but more
investigation are needed to see if there is no other issues in the
scheduler.

12478263: RFC: [RFC,mptcp-next,1/4] mptcp: add a new sysctl scheduler
12478265: RFC: [RFC,mptcp-next,2/4] mptcp: add struct mptcp_sched_ops
12478267: RFC: [RFC,mptcp-next,3/4] mptcp: round-robin packet scheduler
support
12478269: RFC: [RFC,mptcp-next,4/4] selftests: mptcp: add round-robin
testcase:
    - Series: round-robin packet scheduler support
    - No more discussion, see notes from last week
    - Geliang: what is your plan with this series? Looking at BPF support?

12492583: Changes Requested: [mptcp-next,v3,1/8] mptcp: add
mptcp_is_data_contiguous helper
12492585: Changes Requested: [mptcp-next,v3,2/8] mptcp: add start_seq in
the msk
12492587: Changes Requested: [mptcp-next,v3,3/8] mptcp: infinite mapping
sending
12492589: Changes Requested: [mptcp-next,v3,4/8] mptcp: add the fallback
check
12492591: Changes Requested: [mptcp-next,v3,5/8] mptcp: infinite mapping
receiving
12492593: Changes Requested: [mptcp-next,v3,6/8] mptcp: add mib for
infinite map sending
12492595: Changes Requested: [mptcp-next,v3,7/8] selftests: mptcp: add
infinite map mibs check
12492597: Changes Requested: [mptcp-next,v3,8/8] DO-NOT-MERGE: mptcp:
mp_fail test:
    - series: The infinite mapping support
    - Reviewed by Paolo and Mat
    - Paolo was writing a reply to Mat, see ML

12496107: Queued: mptcp: don't return sockets in foreign netns:
    - Can be applied with the Fixes tag (and s/intp/into/)
    - Might be good to have a storage per netns → avoid clashes?
    - This one is good for the -net tree and another patch can come for
net-next



Issues on Github:
    https://github.com/multipath-tcp/mptcp_net-next/issues/


    Recently opened (latest from last week: 230)

    /

    Bugs (opened, flagged as "bug" and assigned)

    /

    Bugs (opened and flagged as "bug" and not assigned)

  230  selftests: mptcp_connect: poll timed_out [bug] [selftests]:
      - Probably fixed with the same patch as for issue 226
      - TODO: Matth: rerun the public CI a few times → done

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

  216  The infinite mapping support [enhancement] @geliangtang:
      - See above

  194  Round-robin packet scheduler support [enhancement] @geliangtang:
      - See above

  186  Add netlink command support [enhancement] @mjmartineau:
      - Florian found that there are already conflicts with existing
commands and the ones from mptcp.org
      - Discussions can continue on the ticket

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

  226  selftests: `mptcp_join.sh -l`: copyfd_io_poll: poll timed out
error [bug] [selftests] @fw-strlen



FYI: Current Roadmap:
    - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
    - Current/Coming merge window (5.16):
https://github.com/multipath-tcp/mptcp_net-next/projects/11
    - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4



Patches to send to netdev:
    - net:
        - "mptcp: don't return sockets in foreign netns"
        - Maybe best to wait a bit before sending this one (get some
feedback)

    - net-next:
        - the series to remove tcp skb cache should be ready:
            - it indirectly fixes: "WARNING in mptcp_sendmsg_frag" seen
by Syzbot
            - but we need something else for -net
            - Paolo would like to send the series because Eric is
waiting for it
            - There is a conflict with the two: fixes for -net and the
removal for net-next
            - Maybe best to send the series as an RFC with an
explanation it will conflict with the other patch
            - Paolo will send it
        - MPTCP_INFO:
            - can be sent
            - Mat will send it
        - A few other individual patches are pending too:
            - but not in a hurry, we can send them with others later



Extra tests:
    - news about Syzkaller? (Christoph / Mat):
        - Warning reported by syzbot:
https://lore.kernel.org/mptcp/000000000000bf031105cc00ced8@google.com/

    - May be fixed by "mptcp: stop relying on tcp_tx_skb_cache" in the
export branch

    - Condition is handled. Remove the WARN_ON_ONCE() in the net tree,
or troubleshoot more?

    - See above: Paolo is looking at a fix

        - Mat: Might be good to run syzbot with/without debug options to
find other types of issues.

    - news about interop with mptcp.org/other stacks? (Christoph):
        - /

    - news about Intel's kbuild? (Mat):
        - Running again with "kbuild: Only default to -Werror if
COMPILE_TEST"
        - Validating MPTCP selftests and no issues so far

    - packetdrill (Davide):
        - Poorva is looking at the issue #215 (TCP Urgent pointer and MPTCP)
        - But we need to look at the checksum support → would be useful
for (many) other validation:
            - checksum support is already there (for MPTCP v0) but untested
            - we need to adapt it to v1
        - gtests/net/mptcp/sockopts is failing:
            - Matth: TODO: check that → Done

    - Patchew (Davide):
        - migrated the importer from a laptop to elsewhere but it is not
the final place
        - but the importer is "stateless", we can easily migrate it later
        - a new Github has been created
        - for the moment, the user is hardcoded but maybe we don't care
        - Davide will share credentials with Matth to try.

    - CI (Matth):
        - /



mptcpd: addr_add improvements/tuning:
    - Paolo tried it recently
    - One plugin is available for the moment and Paolo noticed a few issues:
        - New endpoints are created but without any flags (flags=0 → no
signal/create/fullmesh):
            - Paolo has a patch for that adding a new config to change flags
            → only useful for the upstream kernel but that's normal
        - if IPs are changed, they are no longer used (if I understood
correctly)
        - Some issues with addresses set on the loopback interface:
            - probably better to look at the scope of the address and
not the interface
        - We also need to change "MPTCP limits" for the PM: the default
value is "too low" (on purpose):
            - Paolo also has a patch to add a new config option.
    - Might be good to have a new release after that ↑ :)




Next meeting:
    - On Thursday, the 23th of September.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210923



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
