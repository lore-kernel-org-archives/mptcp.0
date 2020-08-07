Content-Type: multipart/mixed; boundary="===============9002613671690000557=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 6th of August 2020
Date: Fri, 07 Aug 2020 23:40:19 +0200
Message-ID: <7e2b4164-2188-fd8f-4396-f23c8548354c@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5522

--===============9002613671690000557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 111st meeting with Ossama (Intel OTC), Christoph =

(Apple), Paolo, Davide and Florian (RedHat), Geliang (Xiaomi), Nicolas =

and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
     - The list of accepted patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D3

     netdev (if mptcp ML is in cc) (Geliang Tang, Paolo Abeni):

1340921  [net] mptcp: be careful on subflow creation
1340373  [net] mptcp: fix bogus sendmsg() return code under pressure
1340308  [net-next] mptcp: use mptcp_for_each_subflow in mptcp_stream_ac
+ SYN cookies (from Florian)

     our repo (by: Paolo Abeni):

1339501  [net] mptcp: fix bogus sendmsg() return code under pressure



Pending patches:
     - The list of pending patches can be seen on PatchWork:
       https://patchwork.ozlabs.org/project/mptcp/list/?state=3D*

     netdev (if mptcp ML is in cc) (by: /):

/

     our repo (by: Christoph Paasch, Geliang Tang, Matthieu Baerts, =

Nicolas Rybowski, Paolo Abeni):

1325171: Changes Requested: [mptcp-next] selftests: mptcp: interpret \n =

as a new line:
     - Matth: TODO...

1337426: Changes Requested: [mptcp-next] selftests/mptcp: Better delay & =

reordering configuration:
     - Changes requested

1340389: Rejected: mptcp: Allow ip mptcp endpoint show:
     - Already sent =E2=86=92 iproute2 switched to "main" branch instead of=
 "master"

1340771: New: [v5,mptcp-next,1/4] mptcp: rename addr_signal and the =

related functions
1340772: New: [v5,mptcp-next,2/4] mptcp: add the outgoing RM_ADDR support
1340774: New: [v5,mptcp-next,3/4] mptcp: add the incoming RM_ADDR support
1340775: New: [v5,mptcp-next,4/4] mptcp: remove addr and subflow in PM =

netlink:
     - in some cases, there is a lock
     - Geliang is looking at that
     - a new version will be sent later
     - Paolo suggests to look without the 4th patch
     - It seems it is OK without the 4th one
     - Suggestion: we merge the 3th ones.
     - TODO: Matth: apply the 3 first ones =E2=86=92 done

1340915: New: [mptcp-next,1/4] bpf: expose is_mptcp flag to bpf_tcp_sock
1340916: New: [mptcp-next,2/4] mptcp: attach subflow socket to parent =

cgroup
1340917: New: [mptcp-next,3/4] mptcp: moving struct definitions
1340918: New: [mptcp-next,4/4] bpf: adding 'bpf_mptcp_sock' structure =

and helper:
     - Waiting for reviews
     - Maybe possible to avoid exposing more specific MPTCP structure to =

all the kernel
     - Nicolas is looking at that
     - Create a Github issue?
     - TODO: Matth =E2=86=91 =E2=86=92 done

1341330: New: [01/13] mptcp: rethink 'is writable' conditional
1341334: New: [02/13] mptcp: set data_ready status bit in =

subflow_check_data_avail()
1341332: New: [03/13] mptcp: trigger msk processing even for OoO data
1341336: New: [04/13] mptcp: basic sndbuf autotuning
1341335: New: [05/13] mptcp: introduce and use mptcp_try_coalesce()
1341337: New: [06/13] mptcp: move ooo skbs into msk out of order queue.
1341338: New: [07/13] mptcp: cleanup mptcp_subflow_discard_data()
1341339: New: [08/13] mptcp: add OoO related mibs
1341341: New: [09/13] mptcp: move address attribute into mptcp_addr_info
1341340: New: [10/13] mptcp: allow creating non-backup subflows
1341342: New: [11/13] mptcp: allow picking different xmit subflows
1341344: New: [12/13] mptcp: simult flow self-tests
1341343: New: [13/13] mptcp: cache subflow write status in subflow ctx:
     - Waiting for review
     - Paolo addressed most comments from Florian
     - Idea would be to merge this to have more tests and simplify the =

process
     - TODO: Matth =E2=86=91 =E2=86=92 done
     - Comments reported by Christoph were not applied



Issues on Github:
     https://github.com/multipath-tcp/mptcp_net-next/issues/

     Recently opened (latest from last week: 69)

   72  [iproute2] endpoint add with "id" is not persisted [enhancement] =

[iproute2]:
       - Normal, new feature needed

   71  [interop] Bad mapping: ssn=3D16194949 map_seq=3D16120693 =

map_data_len=3D31416 [bug] [interop]:
       - With Paolo's patches, on going
       - Should be still there with v1
       - more debug will be needed to capture more states
       - with a large transfer: iperf with 4 interfaces from mptcp.org =

to net-next: different VMs on the same host

   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]:
       - Christoph will see if he can reproduce it


     Bugs (open and flagged as "bug")

   71  [interop] Bad mapping: ssn=3D16194949 map_seq=3D16120693 =

map_data_len=3D31416 [bug] [interop]
   70  [syzkaller] WARNING in mptcp_reset_timer [bug] [syzkaller]

   69  Packetdrill: dss: failing with new DATA_FIN patches [bug] @dcaratti:
       - Tests needs to be adapted due to changes in the kernel
       - We would need to cover the cases where DATA_FIN are received =

(1) only in FIN and (2) in ACK+FIN

   68  selftests: diag: failing with new DATA_FIN patches [bug]

   67  `./mptcp_connect.sh -m mmap` timeout [bug]:
       - Can be fixed with Paolo's patch? =E2=86=92 mptcp: fix bogus sendms=
g() =

return code under pressure
       - Not related to that =E2=86=92 fix an error, not a timeout

   66  [interop] IPv4: Attempt to release TCP socket in state 1 =

00000000cbc88a4a [bug] [interop]
   65  clearing properly the status in listen() [bug]
   62  [syzkaller] WARNING in __mptcp_move_skbs_from_subflow [bug] =

[syzkaller]

   56  msk connection state set without msk lock [bug] @pabeni:
       - the race is still there for the client msk socket
       - now much more difficult to raise
       - maybe we should not address it now, seems minor
       - we can keep this one
       - Paolo has been unassigned
       - TODO: Matth: update the status =E2=86=92 done

    6  loss and delay without reordering causes very slow transfer [bug] =

@cpaasch

Paolo reported an issue with ss:
     - mptcp diag interface weirdness
     - easier to send the small fix for iproute2

Paolo found an issue when sending on multiple subflows:
     - If the writer is blocked because send buff is full =E2=86=92 we shou=
ld =

check for space on subflow, not msk
     - still it is an issue for -net but more visible with multiple subflows
     - we can send a patch just for -net (and different one for net-next =

as this has been modified by Paolo's patches)
     - =

https://elixir.bootlin.com/linux/latest/source/net/mptcp/protocol.c#L495
     - should be sk_stream_memory_free(ssk) or sk_stream_memory_free(sk)


     In Progress (open and assigned to someone)

   50  REMOVE_ADDR support [enhancement] @geliangtang

   49  ADD_ADDR: echo bit support [enhancement] @geliangtang:
       - Was assigned to Peter but there was no activity on this for a =

few months
       - Now assigned to Geliang

   43  [syzkaller] Change syzkaller to exercise MPTCP inet_diag =

interface [enhancement] [syzkaller] @cpaasch

   17  allow non 'backup' subflows creation [enhancement] @pabeni


     Recently closed (since last week)

   64  Kernel crash when using `pm_nl_ctl` and `use_mptcp.sh` [bug]
   58  Full DATA_FIN support [enhancement] v5.9 @mjmartineau =E2=80=A1



FYI: Current Roadmap:
     - Bugs: https://github.com/multipath-tcp/mptcp_net-next/projects/2
     - Current merge window (5.9): =

https://github.com/multipath-tcp/mptcp_net-next/projects/1 :
         - TODO: Matth: close =E2=86=91
     - For later: https://github.com/multipath-tcp/mptcp_net-next/projects/4
     - 5.10: https://github.com/multipath-tcp/mptcp_net-next/projects/5



Scheduler with BPF:
     - a lot of BPF helpers are already available

     - possible to do:
         - collect all subflows and put then in a map
         - then using "skb_sk" type, we can ask to assign a skb to a sk
         - current issue: ulp initialisation is done "too soon"
         - more tests to do

     - in the current MPTCP code:
         - we select the path before creating the skb
         - but we might need to change that
         - but changing that might come with some heavy work:
             - a send queue for MPTCP to queue SKB
             - would be good for different perspectives and help for =

this case with BPF

     - a helper could receive some MPTCP info (a DSS mapping + sk) to =

select the subflow:
         - this would expose a new API for this (with specific data =

structures)



Extra tests:
     - news about Syzkaller? (Christoph):
         - / (see the new Github issue)

     - news about interop with mptcp.org? (Christoph):
         - / (see the new Github issue)
         - once Paolo's patches are in the "export" branch, Christoph is =

going to do more tests
         - maybe linked to a reinjection?
         - needs more analyses

     - news about Intel's kbuild? (Mat):
         - /

     - packetdrill (Davide):
         - needed: MP_JOIN tests where we continue reading while a =

subflow didn't finish with a DATA_FIN
         - some MP_JOIN tests are failing, Davide will investigate more

     - CI (Matth):
         - /



Next meeting:
     - Paolo and Matt will not be able to join the meeting next week and =

the week after
     - Christoph will not be able to join the meeting next week

     - We propose to *skip* the meeting next week and have the next one =

on Thursday, the 20th of August if there are enough people.

     - Mat has been unanimously elected to take notes at the next =

meeting :-D

     - Usual time: 15:00 UTC (8am PDT, 5pm CEST, 11pm UTC+8)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20200820



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you next week,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============9002613671690000557==--
