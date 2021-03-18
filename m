Content-Type: multipart/mixed; boundary="===============7845879236281611654=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next] Squash to "bpf:selftests: add
 MPTCP test base"
Date: Thu, 18 Mar 2021 11:47:15 +0800
Message-ID: <9fe955db44222c638db73c3f8446d9d248b8a11c.1616039100.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8206

--===============7845879236281611654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When I ran the bpf mptcp test "./test_progs -n 67", I got a "fallback to
TCP" error and a "Attempt to release TCP socket in state 8" error in the
kernel log:

[ 2904.821675] MPTCP: subflow=3D000000006672aad2
[ 2904.821680] MPTCP: subflow=3D000000006672aad2, family=3D2
[ 2904.821682] MPTCP: subflow=3D000000006672aad2
[ 2904.821719] MPTCP: msk=3D00000000eaccf64d
[ 2904.821724] MPTCP: msk=3D00000000eaccf64d
[ 2904.821735] MPTCP: msk=3D00000000eaccf64d
[ 2904.822786] MPTCP: subflow=3D000000000003ba05
[ 2904.822789] MPTCP: subflow=3D000000000003ba05, family=3D2
[ 2904.822792] MPTCP: subflow=3D000000000003ba05
[ 2904.822827] MPTCP: msk=3D000000005818109c
[ 2904.822831] MPTCP: msk=3D000000005818109c
[ 2904.822868] MPTCP: ssk=3D00000000729b0de5, local_key=3D0, token=3D0, ids=
n=3D0
[ 2904.822924] MPTCP: subflow=3D000000006672aad2
[ 2904.822942] MPTCP: subflow_req=3D0000000025739d62, listener=3D0000000066=
72aad2
[ 2904.822944] MPTCP: MP_CAPABLE version=3D1, flags=3D1, optlen=3D4 sndr=3D=
18446744072231269184, rcvr=3D18446744072228608064 len=3D65535
[ 2904.822949] MPTCP: req=3D0000000025739d62 local_key=3D156076364589784178=
90, token=3D3995930330, idsn=3D4151446240254394327
[ 2904.822961] MPTCP: subflow_req=3D0000000025739d62, local_key=3D156076364=
58978417890
[ 2904.822984] MPTCP: subflow=3D000000000003ba05 synack seq=3Dda2e10fa
[ 2904.822986] MPTCP: MP_CAPABLE version=3D1, flags=3D1, optlen=3D12 sndr=
=3D15607636458978417890, rcvr=3D0 len=3D1
[ 2904.822989] MPTCP: subflow=3D000000000003ba05, remote_key=3D156076364589=
78417890
[ 2904.822990] MPTCP: msk=3D000000005818109c, token=3D3138387826
[ 2904.822993] MPTCP: msk=3D000000005818109c, token=3D3138387826 side=3D0
[ 2904.822997] MPTCP: msk=3D000000005818109c ssk=3D00000000729b0de5 data_av=
ail=3D0 skb=3D0000000000000000
[ 2904.823000] MPTCP: msk=3D000000005818109c ssk=3D00000000729b0de5 status=
=3D2
[ 2904.823007] MPTCP: subflow=3D000000000003ba05, local_key=3D1336047697788=
7136047, remote_key=3D15607636458978417890 map_len=3D0
[ 2904.823018] MPTCP: listener=3D000000006672aad2, req=3D0000000025739d62, =
conn=3D00000000eaccf64d
[ 2904.823020] MPTCP: MP_CAPABLE version=3D1, flags=3D1, optlen=3D20 sndr=
=3D13360476977887136047, rcvr=3D15607636458978417890 len=3D65535
[ 2904.823055] MPTCP: subflow=3D000000002491d623
[ 2904.823064] MPTCP: msk=3D00000000a0271c19, token=3D3995930330 side=3D1
[ 2904.823080] MPTCP: msk=3D00000000a0271c19 ssk=3D000000008dd7431f data_av=
ail=3D0 skb=3D0000000000000000
[ 2904.823082] MPTCP: msk=3D00000000a0271c19 ssk=3D000000008dd7431f status=
=3D2
[ 2904.823084] MPTCP: MP_CAPABLE version=3D1, flags=3D1, optlen=3D20 sndr=
=3D13360476977887136047, rcvr=3D15607636458978417890 len=3D38754
[ 2904.823104] MPTCP: msk=3D000000005818109c snd_data_fin_enable=3D0 shutdo=
wn=3D3 state=3D4 pending=3D0
[ 2904.823107] MPTCP: msk=3D000000005818109c snd_data_fin_enable=3D1 pendin=
g=3D0 snd_nxt=3D5209280520537872386 write_seq=3D5209280520537872387
[ 2904.823110] MPTCP: Sending DATA_FIN on subflow 00000000729b0de5
[ 2904.823128] MPTCP: DSS
[ 2904.823131] MPTCP: data_fin=3D1 dsn64=3D1 use_map=3D1 ack64=3D0 use_ack=
=3D1
[ 2904.823133] MPTCP: data_ack=3D914259928
[ 2904.823134] MPTCP: data_seq=3D5209280520537872386 subflow_seq=3D0 data_l=
en=3D1
[ 2904.823150] MPTCP: msk=3D000000005818109c state=3D4
[ 2904.823212] MPTCP: msk=3D00000000eaccf64d state=3D7
[ 2904.823214] MPTCP: msk=3D00000000eaccf64d
[ 2904.823240] MPTCP: subflow_req=3D0000000025739d62
[ 2904.823250] MPTCP: check_fully_established:fallback to TCP (msk=3D000000=
005818109c)
[ 2904.823306] MPTCP: msk=3D00000000eaccf64d
[ 2904.823526] MPTCP: msk=3D00000000a0271c19 snd_data_fin_enable=3D0 pendin=
g=3D0 snd_nxt=3D4151446240254394328 write_seq=3D4151446240254394328
[ 2904.823533] MPTCP: msk=3D00000000a0271c19
[ 2904.823535] IPv4: Attempt to release TCP socket in state 8 00000000a0271=
c19
[ 2954.415879] MPTCP: msk=3D00000000474e8657 snd_data_fin_enable=3D1 pendin=
g=3D0 snd_nxt=3D14603538848639169953 write_seq=3D14603538848639169953
[ 2954.415911] MPTCP: msk=3D00000000474e8657
[ 2954.416151] MPTCP: msk=3D00000000474e8657
[ 2966.704256] MPTCP: msk=3D000000005818109c snd_data_fin_enable=3D1 pendin=
g=3D0 snd_nxt=3D5209280520537872387 write_seq=3D5209280520537872387
[ 2966.704279] MPTCP: msk=3D000000005818109c

This patch fixed them.

For the first error, adding send_byte can fix it. The send_byte function is
copied from tools/testing/selftests/bpf/prog_tests/tcp_rtt.c.

For the second error, we need to close the server fd before closing the
client fd.

With this patch, no error in the kernel log output when raning the bpf test:

[ 2539.428250] MPTCP: msk=3D00000000d7aad9c1
[ 2558.122417] MPTCP: subflow=3D0000000045a3636c
[ 2558.122421] MPTCP: subflow=3D0000000045a3636c, family=3D2
[ 2558.122424] MPTCP: subflow=3D0000000045a3636c
[ 2558.122457] MPTCP: msk=3D00000000474e8657
[ 2558.122461] MPTCP: msk=3D00000000474e8657
[ 2558.122473] MPTCP: msk=3D00000000474e8657
[ 2558.123568] MPTCP: subflow=3D000000000f8d06f6
[ 2558.123571] MPTCP: subflow=3D000000000f8d06f6, family=3D2
[ 2558.123573] MPTCP: subflow=3D000000000f8d06f6
[ 2558.123607] MPTCP: msk=3D00000000eaccf64d
[ 2558.123611] MPTCP: msk=3D00000000eaccf64d
[ 2558.123648] MPTCP: ssk=3D0000000049c4c5ec, local_key=3D0, token=3D0, ids=
n=3D0
[ 2558.123701] MPTCP: subflow=3D0000000045a3636c
[ 2558.123718] MPTCP: subflow_req=3D0000000025739d62, listener=3D0000000045=
a3636c
[ 2558.123720] MPTCP: MP_CAPABLE version=3D1, flags=3D1, optlen=3D4 sndr=3D=
18446744072231269184, rcvr=3D18446744072228608064 len=3D65535
[ 2558.123725] MPTCP: req=3D0000000025739d62 local_key=3D833954766036575697=
, token=3D1721321063, idsn=3D15537260029657244048
[ 2558.123735] MPTCP: subflow_req=3D0000000025739d62, local_key=3D833954766=
036575697
[ 2558.123757] MPTCP: subflow=3D000000000f8d06f6 synack seq=3D285a036
[ 2558.123759] MPTCP: MP_CAPABLE version=3D1, flags=3D1, optlen=3D12 sndr=
=3D833954766036575697, rcvr=3D0 len=3D1
[ 2558.123761] MPTCP: subflow=3D000000000f8d06f6, remote_key=3D833954766036=
575697
[ 2558.123763] MPTCP: msk=3D00000000eaccf64d, token=3D2492018137
[ 2558.123765] MPTCP: msk=3D00000000eaccf64d, token=3D2492018137 side=3D0
[ 2558.123770] MPTCP: msk=3D00000000eaccf64d ssk=3D0000000049c4c5ec data_av=
ail=3D0 skb=3D0000000000000000
[ 2558.123772] MPTCP: msk=3D00000000eaccf64d ssk=3D0000000049c4c5ec status=
=3D2
[ 2558.123779] MPTCP: subflow=3D000000000f8d06f6, local_key=3D1088354515732=
031164, remote_key=3D833954766036575697 map_len=3D0
[ 2558.123790] MPTCP: listener=3D0000000045a3636c, req=3D0000000025739d62, =
conn=3D00000000474e8657
[ 2558.123793] MPTCP: MP_CAPABLE version=3D1, flags=3D1, optlen=3D20 sndr=
=3D1088354515732031164, rcvr=3D833954766036575697 len=3D65535
[ 2558.123813] MPTCP: subflow=3D0000000079746efe
[ 2558.123820] MPTCP: msk=3D000000005818109c, token=3D1721321063 side=3D1
[ 2558.123836] MPTCP: msk=3D000000005818109c ssk=3D00000000d6227d49 data_av=
ail=3D0 skb=3D0000000000000000
[ 2558.123838] MPTCP: msk=3D000000005818109c ssk=3D00000000d6227d49 status=
=3D2
[ 2558.123840] MPTCP: MP_CAPABLE version=3D1, flags=3D1, optlen=3D20 sndr=
=3D1088354515732031164, rcvr=3D833954766036575697 len=3D38754
[ 2558.123868] MPTCP: msk=3D00000000eaccf64d dfrag at seq=3D783947682013322=
7673 len=3D1 sent=3D0 new=3D1
[ 2558.123871] MPTCP: msk=3D00000000eaccf64d nr_active=3D1 ssk=3D0000000049=
c4c5ec:0 backup=3D0000000000000000:-1
[ 2558.123874] MPTCP: msk=3D00000000eaccf64d ssk=3D0000000049c4c5ec sending=
 dfrag at seq=3D7839476820133227673 len=3D1 already sent=3D0
[ 2558.123877] MPTCP: data_seq=3D7839476820133227673 subflow_seq=3D1 data_l=
en=3D1 dsn64=3D1
[ 2558.123880] MPTCP: subflow=3D000000000f8d06f6, local_key=3D1088354515732=
031164, remote_key=3D833954766036575697 map_len=3D1
[ 2558.123892] MPTCP: MP_CAPABLE version=3D1, flags=3D1, optlen=3D22 sndr=
=3D1088354515732031164, rcvr=3D833954766036575697 len=3D1
[ 2558.123899] MPTCP: msk=3D000000005818109c ssk=3D00000000d6227d49 data_av=
ail=3D0 skb=3D00000000d6c38daf
[ 2558.123902] MPTCP: seq=3D7839476820133227673 is64=3D1 ssn=3D1 data_len=
=3D1 data_fin=3D0
[ 2558.123904] MPTCP: new map seq=3D7839476820133227673 subflow_seq=3D1 dat=
a_len=3D1
[ 2558.123911] MPTCP: msk=3D000000005818109c ssk=3D00000000d6227d49 status=
=3D0
[ 2558.123912] MPTCP: msk ack_seq=3D6ccb6aa1f0f32c99 subflow ack_seq=3D6ccb=
6aa1f0f32c99
[ 2558.123915] MPTCP: msk=3D000000005818109c ssk=3D00000000d6227d49
[ 2558.123917] MPTCP: Done with mapping: seq=3D1 data_len=3D1
[ 2558.123919] MPTCP: msk=3D000000005818109c ssk=3D00000000d6227d49 data_av=
ail=3D0 skb=3D0000000000000000
[ 2558.123921] MPTCP: msk=3D000000005818109c ssk=3D00000000d6227d49 status=
=3D2
[ 2558.123923] MPTCP: msk=3D000000005818109c empty=3D1
[ 2558.123946] MPTCP: DSS
[ 2558.123947] MPTCP: data_fin=3D0 dsn64=3D0 use_map=3D0 ack64=3D1 use_ack=
=3D1
[ 2558.123949] MPTCP: data_ack=3D7839476820133227674
[ 2558.123951] MPTCP: msk=3D00000000eaccf64d
[ 2558.123959] MPTCP: msk=3D00000000eaccf64d snd_data_fin_enable=3D0 pendin=
g=3D0 snd_nxt=3D7839476820133227674 write_seq=3D7839476820133227674
[ 2558.123968] MPTCP: msk=3D00000000474e8657 state=3D7
[ 2558.123970] MPTCP: msk=3D00000000474e8657
[ 2558.123995] MPTCP: msk=3D000000005818109c
[ 2558.124012] MPTCP: subflow_req=3D0000000025739d62
[ 2558.124028] MPTCP: msk=3D00000000eaccf64d ssk=3D0000000049c4c5ec data_av=
ail=3D0 skb=3D0000000000000000
[ 2558.124031] MPTCP: msk=3D00000000eaccf64d ssk=3D0000000049c4c5ec status=
=3D2
[ 2558.124064] MPTCP: msk=3D00000000eaccf64d status=3D10
[ 2558.124066] MPTCP: msk=3D00000000eaccf64d snd_data_fin_enable=3D0 pendin=
g=3D0 snd_nxt=3D7839476820133227674 write_seq=3D7839476820133227674
[ 2558.124109] MPTCP: msk=3D00000000474e8657
[ 2558.124133] MPTCP: msk=3D00000000eaccf64d snd_data_fin_enable=3D0 shutdo=
wn=3D3 state=3D4 pending=3D0
[ 2558.124135] MPTCP: msk=3D00000000eaccf64d snd_data_fin_enable=3D1 pendin=
g=3D0 snd_nxt=3D7839476820133227674 write_seq=3D7839476820133227675

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
v2:
 - fix "Attempt to release TCP socket in state 8" error too.
 - add full kernel log in the commit log.
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 0e65d64868e9..79783bf8bf18 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -8,6 +8,14 @@ struct mptcp_storage {
 	__u32 is_mptcp;
 };
 =

+static void send_byte(int fd)
+{
+	char b =3D 0x55;
+
+	if (CHECK_FAIL(write(fd, &b, sizeof(b)) !=3D 1))
+		perror("Failed to send single byte");
+}
+
 static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
 {
 	int err =3D 0, cfd =3D client_fd;
@@ -76,9 +84,13 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
 		goto close_client_fd;
 	}
 =

+	send_byte(client_fd);
+
 	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
 			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
 =

+	close(server_fd);
+
 close_client_fd:
 	close(client_fd);
 =

@@ -102,8 +114,6 @@ void test_mptcp(void)
 =

 	CHECK_FAIL(run_test(cgroup_fd, server_fd, false));
 =

-	close(server_fd);
-
 with_mptcp:
 	/* with MPTCP */
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
@@ -112,8 +122,6 @@ void test_mptcp(void)
 =

 	CHECK_FAIL(run_test(cgroup_fd, server_fd, true));
 =

-	close(server_fd);
-
 close_cgroup_fd:
 	close(cgroup_fd);
 }
-- =

2.30.2

--===============7845879236281611654==--
