Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE554964E
	for <mptcp@lists.linux.dev>; Mon, 16 Jun 2025 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750055933; cv=none; b=FrM2GcuzYgKN9F8i69sTDuqDUD5zF/pZmZjh4KiIPI6FRM/gPlf+v/6qPbmYyd0h1Vw65SfAna9gFxJaW9kCIrcRPtWbV3eLP7b76ygsEG8rrE6AZcwisbajCVBCHhRdEvl17PBHLNf3fva9ZjpuzH9L/Lp933xJfjVONI+pnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750055933; c=relaxed/simple;
	bh=BT02zqnN2AzygXjSt/gUivIrA27ICFjx6U57UHSNaO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6elzaWrfhV40V9EYfjJZHl8DfBWkP2hNsemiYP0CoWk722+8VfE/koA8y3miw1s8HCtMba8d5h0hBOfaZmmJi7FMILu9kSmp+CEQqsbExdWb623ZocG7h27Vwl7k8Wg2Qb0DMqo/GwuzX/Lg6l/zAX2zwQJdK5IqGLIZruA9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTMJKQWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTMJKQWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8315AC4CEEA;
	Mon, 16 Jun 2025 06:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750055932;
	bh=BT02zqnN2AzygXjSt/gUivIrA27ICFjx6U57UHSNaO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OTMJKQWshMCcNSvTD5rSVyG818igZ4Ug+pGodVOs9bTPxV/mutdH2EakRillxlHpj
	 sJ4tTwjoBlXJaEx2XHscW2ZLZzcBh4319iGucJrUBiwUfOOFgMtPP53O1U/6uaPG7B
	 c4XMuco67G0NuEzMl9CAeLLTsGW4WRqPn68gntpreoKFE9y0Z5jq9AmphCQaM2kc0r
	 jxef/sb/qZdK2kHGgJJCZtENwXOTldyX6kmikuQmaKa8JK0bS7hWcHprKTPEWcXZkC
	 4JdLwK6WGwHmeoISw259HgJ8CoUImL+Yeaj9N8SW7Trl2WclxdqCvJ3HC1e28WA95T
	 woJp072yCe4BQ==
Message-ID: <76e9ae1378ea43e0fdf00be1f7d38d2dcbefe9c1.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/3] send() fails with EAGAIN in blocking
 IO mode #487
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 16 Jun 2025 14:38:38 +0800
In-Reply-To: <23fd5569-f383-441e-9be4-48a8430954d9@kernel.org>
References: <cover.1748484770.git.tanggeliang@kylinos.cn>
		 <a5c20f9f-3038-ed11-b78c-522ef40f9031@kernel.org>
		 <23fd5569-f383-441e-9be4-48a8430954d9@kernel.org>
Content-Type: multipart/mixed; boundary="=-ozoXqAR4n9xZB/uiLXfq"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

--=-ozoXqAR4n9xZB/uiLXfq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Matt, Mat,

On Sun, 2025-06-15 at 23:29 +0200, Matthieu Baerts wrote:
> Hi Mat, Geliang,
> 
> On 14/06/2025 01:11, Mat Martineau wrote:
> > On Thu, 29 May 2025, Geliang Tang wrote:
> > 
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > Good news! I finally solved the unstable issue of MPTCP BPF sched
> > > selftests
> > > I reported a year ago, #487 "send() fails with EAGAIN in blocking
> > > IO
> > > mode".
> > > 
> > > The fix is simple, it can be solved by explicitly setting
> > > SO_SNDBUF
> > > sockopt, but be sure not to set SO_RCVBUF at the same time
> > > (see sk->sk_userlocks & SOCK_RCVBUF_LOCK in
> > > mptcp_rcv_space_adjust()).
> > > 
> > > With this fix, BPF sched selftests are now very stable, I run
> > > loop
> > > testing
> > > using mptcp-upstream-virtme-docker (run_loop run_bpftest_all),
> > > and can
> > > run
> > > it normally for hundreds of times without error:
> > > 
> > 
> > Hi Geliang -
> > 
> > I can see how changing SO_SNDBUF on the sending socket side would
> > shift
> > timing behavior in a way that affect the test outcome, but it
> > doesn't
> > address the root issue with bug #487:
> > 
> > It is either OK to get an EAGAIN from a blocking send(), or it's
> > not OK.
> > 
> > 
> > If it's not ok to ever return EAGAIN from a blocking send, the
> > existing
> > test code is a reproducer for a bug, and changing the test is
> > hiding
> > that bug.
> > 
> > If EAGAIN is ok, then we should change the code in
> > send_recv_server() to
> > allow it.

I did try to handle EAGAIN in send_recv_server() but it didn't work.
MPTCP BPF sched selftests still fail. Test code and results are
attached.

I added this in send_recv_server():

	if (errno == EAGAIN && again < 5) {
		again++;
		continue;
	}

And still got the EAGAIN error:

# (network_helpers.c:728: errno: Resource temporarily unavailable) send
7867500 expected 10485760
# (network_helpers.c:782: errno: Resource temporarily unavailable) recv
3469500 ​​expected 10485760
# (network_helpers.c:790: errno: Resource temporarily unavailable)
Failed in thread_ret -11
# send_data_and_verify:FAIL:send_recv_data unexpected error: -11 (errno
11)

In addition, BPF selftests adds a new mechanism that does not allow any
test item to run for more than 10 seconds. Otherwise, the following
error will be reported:

# WATCHDOG: test case mptcp/default executes for 10 seconds...

In my testing, I have not found any other solution besides limiting the
send buffer. This allows data to be sent at a constant rate, which
ensures the stability of MPTCP BPF sched selftests.

In order to avoid hiding this bug, we can add a test item for this in
mptcp selftest in the future, like in [1].

WDYT?

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/cover/cover.1722502941.git.tanggeliang@kylinos.cn/

> 
> It is now a bit hidden in the middle of #487, but if I'm not
> mistaken,
> it is OK to get EAGAIN with a blocking send() **if** SO_SNDTIMEO is
> used, and in case of timeout.
> 
> See:
> https://github.com/multipath-tcp/mptcp_net-next/issues/487#issuecomment-2485577676
> 
> So I think the question should be: is it normal to block for longer
> than
> the timeout period (which is a "long" period, no?)? If yes, then
> limiting the send buffer might be a solution, but as Mat said, it
> looks
> better to understand the root cause than hiding a bug :)
> 
> Cheers,
> Matt

--=-ozoXqAR4n9xZB/uiLXfq
Content-Disposition: attachment; filename="bpf-sched-selftests-eagain-err.diff"
Content-Type: text/x-patch; name="bpf-sched-selftests-eagain-err.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9uZXR3b3JrX2hlbHBlcnMu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9uZXR3b3JrX2hlbHBlcnMuYwppbmRleCA5
Y2RiODAxMjc4MDQuLmU5OTY2MjgyYjY2NCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmL25ldHdvcmtfaGVscGVycy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9uZXR3b3JrX2hlbHBlcnMuYwpAQCAtOTQsMTEgKzk0LDExIEBAIGludCBzZXR0aW1lbyhp
bnQgZmQsIGludCB0aW1lb3V0X21zKQogCiBzdGF0aWMgaW50IHNldHNuZGJ1ZihpbnQgZmQsIHVp
bnQzMl90IHNuZGJ1ZikKIHsKLQlpZiAoc25kYnVmID4gMCAmJgotCSAgICBzZXRzb2Nrb3B0KGZk
LCBTT0xfU09DS0VULCBTT19TTkRCVUYsICZzbmRidWYsIHNpemVvZihzbmRidWYpKSkgewotCQls
b2dfZXJyKCJGYWlsZWQgdG8gc2V0IFNPX1NOREJVRiIpOwotCQlyZXR1cm4gLTE7Ci0JfQorCS8v
aWYgKHNuZGJ1ZiA+IDAgJiYKKwkvLyAgICBzZXRzb2Nrb3B0KGZkLCBTT0xfU09DS0VULCBTT19T
TkRCVUYsICZzbmRidWYsIHNpemVvZihzbmRidWYpKSkgeworCS8vCWxvZ19lcnIoIkZhaWxlZCB0
byBzZXQgU09fU05EQlVGIik7CisJLy8JcmV0dXJuIC0xOworCS8vfQogCiAJcmV0dXJuIDA7CiB9
CkBAIC02ODgsNiArNjg4LDcgQEAgc3RhdGljIHZvaWQgKnNlbmRfcmVjdl9zZXJ2ZXIodm9pZCAq
YXJnKQogCXNzaXplX3QgbnJfc2VudCA9IDAsIGJ5dGVzID0gMDsKIAljaGFyIGJhdGNoWzE1MDBd
OwogCWludCBlcnIgPSAwLCBmZDsKKwlpbnQgYWdhaW4gPSAwOwogCiAJZmQgPSBhY2NlcHQoYS0+
ZmQsIE5VTEwsIE5VTEwpOwogCXdoaWxlIChmZCA9PSAtMSkgewpAQCAtNzEzLDYgKzcxNCwxMCBA
QCBzdGF0aWMgdm9pZCAqc2VuZF9yZWN2X3NlcnZlcih2b2lkICphcmcpCiAJCWlmIChucl9zZW50
ID09IC0xICYmIGVycm5vID09IEVJTlRSKQogCQkJY29udGludWU7CiAJCWlmIChucl9zZW50ID09
IC0xKSB7CisJCQlpZiAoZXJybm8gPT0gRUFHQUlOICYmIGFnYWluIDwgNSkgeworCQkJCWFnYWlu
Kys7CisJCQkJY29udGludWU7CisJCQl9CiAJCQllcnIgPSAtZXJybm87CiAJCQlicmVhazsKIAkJ
fQpAQCAtNzQ3LDYgKzc1Miw3IEBAIGludCBzZW5kX3JlY3ZfZGF0YShpbnQgbGZkLCBpbnQgZmQs
IHVpbnQzMl90IHRvdGFsX2J5dGVzLCB1aW50MzJfdCBzbmRidWYpCiAJcHRocmVhZF90IHNydl90
aHJlYWQ7CiAJdm9pZCAqdGhyZWFkX3JldDsKIAljaGFyIGJhdGNoWzE1MDBdOworCWludCBhZ2Fp
biA9IDA7CiAJaW50IGVyciA9IDA7CiAKIAllcnIgPSBwdGhyZWFkX2NyZWF0ZSgmc3J2X3RocmVh
ZCwgTlVMTCwgc2VuZF9yZWN2X3NlcnZlciwgKHZvaWQgKikmYXJnKTsKQEAgLTc2Miw2ICs3Njgs
MTAgQEAgaW50IHNlbmRfcmVjdl9kYXRhKGludCBsZmQsIGludCBmZCwgdWludDMyX3QgdG90YWxf
Ynl0ZXMsIHVpbnQzMl90IHNuZGJ1ZikKIAkJaWYgKG5yX3JlY3YgPT0gLTEgJiYgZXJybm8gPT0g
RUlOVFIpCiAJCQljb250aW51ZTsKIAkJaWYgKG5yX3JlY3YgPT0gLTEpIHsKKwkJCWlmIChlcnJu
byA9PSBFQUdBSU4gJiYgYWdhaW4gPCA1KSB7CisJCQkJYWdhaW4rKzsKKwkJCQljb250aW51ZTsK
KwkJCX0KIAkJCWVyciA9IC1lcnJubzsKIAkJCWJyZWFrOwogCQl9Cg==


--=-ozoXqAR4n9xZB/uiLXfq
Content-Disposition: attachment; filename="bpf-sched-selftests-eagain-err.log"
Content-Type: text/x-log; name="bpf-sched-selftests-eagain-err.log"; charset="UTF-8"
Content-Transfer-Encoding: base64

Cgk9PT0gQXR0ZW1wdDogMjggKFNhdCwgMTQgSnVuIDIwMjUgMTI6MzE6MTcgKzAwMDApID09PQoK
CkJQRiBUZXN0OiB0ZXN0X3Byb2dzIC10IG1wdGNwClRBUCB2ZXJzaW9uIDEzCjEuLjEKIyBXQVRD
SERPRzogdGVzdCBjYXNlIG1wdGNwL2RlZmF1bHQgZXhlY3V0ZXMgZm9yIDEwIHNlY29uZHMuLi4K
IyAjMjAzLzEgICBtcHRjcC9iYXNlOk9LCiMgIzIwMy8yICAgbXB0Y3AvbXB0Y3BpZnk6T0sKIyAj
MjAzLzMgICBtcHRjcC9zdWJmbG93Ok9LCiMgYWRkcmVzc19pbml0OlBBU1M6aXAgLW5ldCBtcHRj
cF9ucyBsaW5rIGFkZCB2ZXRoMSB0eXBlIHZldGggcGVlciBuYW1lIHZldGgyIDAgbnNlYwojIGFk
ZHJlc3NfaW5pdDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgYWRkciBhZGQgMTAuMC4xLjEvMjQgZGV2
IHZldGgxIDAgbnNlYwojIGFkZHJlc3NfaW5pdDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgYWRkciBh
ZGQgZGVhZDpiZWVmOjE6OjEvNjQgZGV2IHZldGgxIG5vZGFkIDAgbnNlYwojIGFkZHJlc3NfaW5p
dDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgbGluayBzZXQgZGV2IHZldGgxIHVwIDAgbnNlYwojIGFk
ZHJlc3NfaW5pdDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgYWRkciBhZGQgMTAuMC4yLjEvMjQgZGV2
IHZldGgyIDAgbnNlYwojIGFkZHJlc3NfaW5pdDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgYWRkciBh
ZGQgZGVhZDpiZWVmOjI6OjEvNjQgZGV2IHZldGgyIG5vZGFkIDAgbnNlYwojIGFkZHJlc3NfaW5p
dDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgbGluayBzZXQgZGV2IHZldGgyIHVwIDAgbnNlYwojIGFk
ZHJlc3NfaW5pdDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgbGluayBhZGQgdmV0aDMgdHlwZSB2ZXRo
IHBlZXIgbmFtZSB2ZXRoNCAwIG5zZWMKIyBhZGRyZXNzX2luaXQ6UEFTUzppcCAtbmV0IG1wdGNw
X25zIGFkZHIgYWRkIDEwLjAuMy4xLzI0IGRldiB2ZXRoMyAwIG5zZWMKIyBhZGRyZXNzX2luaXQ6
UEFTUzppcCAtbmV0IG1wdGNwX25zIGFkZHIgYWRkIGRlYWQ6YmVlZjozOjoxLzY0IGRldiB2ZXRo
MyBub2RhZCAwIG5zZWMKIyBhZGRyZXNzX2luaXQ6UEFTUzppcCAtbmV0IG1wdGNwX25zIGxpbmsg
c2V0IGRldiB2ZXRoMyB1cCAwIG5zZWMKIyBhZGRyZXNzX2luaXQ6UEFTUzppcCAtbmV0IG1wdGNw
X25zIGFkZHIgYWRkIDEwLjAuNC4xLzI0IGRldiB2ZXRoNCAwIG5zZWMKIyBhZGRyZXNzX2luaXQ6
UEFTUzppcCAtbmV0IG1wdGNwX25zIGFkZHIgYWRkIGRlYWQ6YmVlZjo0OjoxLzY0IGRldiB2ZXRo
NCBub2RhZCAwIG5zZWMKIyBhZGRyZXNzX2luaXQ6UEFTUzppcCAtbmV0IG1wdGNwX25zIGxpbmsg
c2V0IGRldiB2ZXRoNCB1cCAwIG5zZWMKIyBzY2hlZF9pbml0OlBBU1M6aXAgbmV0bnMgZXhlYyBt
cHRjcF9ucyBzeXNjdGwgLXF3IG5ldC5tcHRjcC5zY2hlZHVsZXI9ZGVmYXVsdCAwIG5zZWMKIyB0
ZXN0X2RlZmF1bHQ6UEFTUzpzY2hlZF9pbml0IDAgbnNlYwojIHNlbmRfZGF0YV9hbmRfdmVyaWZ5
OlBBU1M6c3RhcnRfbXB0Y3Bfc2VydmVyIDAgbnNlYwojIHNlbmRfZGF0YV9hbmRfdmVyaWZ5OlBB
U1M6Y29ubmVjdF90b19mZCAwIG5zZWMKIyAobmV0d29ya19oZWxwZXJzLmM6NzI4OiBlcnJubzog
UmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUpIHNlbmQgNzg2NzUwMCBleHBlY3RlZCAx
MDQ4NTc2MAojIChuZXR3b3JrX2hlbHBlcnMuYzo3ODI6IGVycm5vOiBSZXNvdXJjZSB0ZW1wb3Jh
cmlseSB1bmF2YWlsYWJsZSkgcmVjdiAzNDY5NTAwIGV4cGVjdGVkIDEwNDg1NzYwCiMgKG5ldHdv
cmtfaGVscGVycy5jOjc5MDogZXJybm86IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxl
KSBGYWlsZWQgaW4gdGhyZWFkX3JldCAtMTEKIyBzZW5kX2RhdGFfYW5kX3ZlcmlmeTpGQUlMOnNl
bmRfcmVjdl9kYXRhIHVuZXhwZWN0ZWQgZXJyb3I6IC0xMSAoZXJybm8gMTEpCiMgIzIwMy80ICAg
bXB0Y3AvZGVmYXVsdDpGQUlMCiMgIzIwMy81ICAgbXB0Y3AvZmlyc3Q6T0sKIyAjMjAzLzYgICBt
cHRjcC9ia3VwOk9LCiMgIzIwMy83ICAgbXB0Y3AvcnI6T0sKIyAjMjAzLzggICBtcHRjcC9yZWQ6
T0sKIyAjMjAzLzkgICBtcHRjcC9idXJzdDpPSwojICMyMDMgICAgIG1wdGNwOkZBSUwKIyAKIyBB
bGwgZXJyb3IgbG9nczoKIyBhZGRyZXNzX2luaXQ6UEFTUzppcCAtbmV0IG1wdGNwX25zIGxpbmsg
YWRkIHZldGgxIHR5cGUgdmV0aCBwZWVyIG5hbWUgdmV0aDIgMCBuc2VjCiMgYWRkcmVzc19pbml0
OlBBU1M6aXAgLW5ldCBtcHRjcF9ucyBhZGRyIGFkZCAxMC4wLjEuMS8yNCBkZXYgdmV0aDEgMCBu
c2VjCiMgYWRkcmVzc19pbml0OlBBU1M6aXAgLW5ldCBtcHRjcF9ucyBhZGRyIGFkZCBkZWFkOmJl
ZWY6MTo6MS82NCBkZXYgdmV0aDEgbm9kYWQgMCBuc2VjCiMgYWRkcmVzc19pbml0OlBBU1M6aXAg
LW5ldCBtcHRjcF9ucyBsaW5rIHNldCBkZXYgdmV0aDEgdXAgMCBuc2VjCiMgYWRkcmVzc19pbml0
OlBBU1M6aXAgLW5ldCBtcHRjcF9ucyBhZGRyIGFkZCAxMC4wLjIuMS8yNCBkZXYgdmV0aDIgMCBu
c2VjCiMgYWRkcmVzc19pbml0OlBBU1M6aXAgLW5ldCBtcHRjcF9ucyBhZGRyIGFkZCBkZWFkOmJl
ZWY6Mjo6MS82NCBkZXYgdmV0aDIgbm9kYWQgMCBuc2VjCiMgYWRkcmVzc19pbml0OlBBU1M6aXAg
LW5ldCBtcHRjcF9ucyBsaW5rIHNldCBkZXYgdmV0aDIgdXAgMCBuc2VjCiMgYWRkcmVzc19pbml0
OlBBU1M6aXAgLW5ldCBtcHRjcF9ucyBsaW5rIGFkZCB2ZXRoMyB0eXBlIHZldGggcGVlciBuYW1l
IHZldGg0IDAgbnNlYwojIGFkZHJlc3NfaW5pdDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgYWRkciBh
ZGQgMTAuMC4zLjEvMjQgZGV2IHZldGgzIDAgbnNlYwojIGFkZHJlc3NfaW5pdDpQQVNTOmlwIC1u
ZXQgbXB0Y3BfbnMgYWRkciBhZGQgZGVhZDpiZWVmOjM6OjEvNjQgZGV2IHZldGgzIG5vZGFkIDAg
bnNlYwojIGFkZHJlc3NfaW5pdDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgbGluayBzZXQgZGV2IHZl
dGgzIHVwIDAgbnNlYwojIGFkZHJlc3NfaW5pdDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgYWRkciBh
ZGQgMTAuMC40LjEvMjQgZGV2IHZldGg0IDAgbnNlYwojIGFkZHJlc3NfaW5pdDpQQVNTOmlwIC1u
ZXQgbXB0Y3BfbnMgYWRkciBhZGQgZGVhZDpiZWVmOjQ6OjEvNjQgZGV2IHZldGg0IG5vZGFkIDAg
bnNlYwojIGFkZHJlc3NfaW5pdDpQQVNTOmlwIC1uZXQgbXB0Y3BfbnMgbGluayBzZXQgZGV2IHZl
dGg0IHVwIDAgbnNlYwojIHNjaGVkX2luaXQ6UEFTUzppcCBuZXRucyBleGVjIG1wdGNwX25zIHN5
c2N0bCAtcXcgbmV0Lm1wdGNwLnNjaGVkdWxlcj1kZWZhdWx0IDAgbnNlYwojIHRlc3RfZGVmYXVs
dDpQQVNTOnNjaGVkX2luaXQgMCBuc2VjCiMgc2VuZF9kYXRhX2FuZF92ZXJpZnk6UEFTUzpzdGFy
dF9tcHRjcF9zZXJ2ZXIgMCBuc2VjCiMgc2VuZF9kYXRhX2FuZF92ZXJpZnk6UEFTUzpjb25uZWN0
X3RvX2ZkIDAgbnNlYwojIChuZXR3b3JrX2hlbHBlcnMuYzo3Mjg6IGVycm5vOiBSZXNvdXJjZSB0
ZW1wb3JhcmlseSB1bmF2YWlsYWJsZSkgc2VuZCA3ODY3NTAwIGV4cGVjdGVkIDEwNDg1NzYwCiMg
KG5ldHdvcmtfaGVscGVycy5jOjc4MjogZXJybm86IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZh
aWxhYmxlKSByZWN2IDM0Njk1MDAgZXhwZWN0ZWQgMTA0ODU3NjAKIyAobmV0d29ya19oZWxwZXJz
LmM6NzkwOiBlcnJubzogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUpIEZhaWxlZCBp
biB0aHJlYWRfcmV0IC0xMQojIHNlbmRfZGF0YV9hbmRfdmVyaWZ5OkZBSUw6c2VuZF9yZWN2X2Rh
dGEgdW5leHBlY3RlZCBlcnJvcjogLTExIChlcnJubyAxMSkKIyAjMjAzLzQgICBtcHRjcC9kZWZh
dWx0OkZBSUwKIyAjMjAzICAgICBtcHRjcDpGQUlMCiMgU3VtbWFyeTogMC84IFBBU1NFRCwgMCBT
S0lQUEVELCAxIEZBSUxFRApub3Qgb2sgMSB0ZXN0OiBicGZ0ZXN0X3Rlc3RfcHJvZ3NfbXB0Y3Ag
IyBGQUlMCiMgdGltZT0yMQpCUEYgVGVzdDogdGVzdF9wcm9ncy1jcHV2NCAtdCBtcHRjcApUQVAg
dmVyc2lvbiAxMwoxLi4xCiMgIzIwMy8xICAgbXB0Y3AvYmFzZTpPSwojICMyMDMvMiAgIG1wdGNw
L21wdGNwaWZ5Ok9LCiMgIzIwMy8zICAgbXB0Y3Avc3ViZmxvdzpPSwojICMyMDMvNCAgIG1wdGNw
L2RlZmF1bHQ6T0sKIyAjMjAzLzUgICBtcHRjcC9maXJzdDpPSwojICMyMDMvNiAgIG1wdGNwL2Jr
dXA6T0sKIyAjMjAzLzcgICBtcHRjcC9ycjpPSwojICMyMDMvOCAgIG1wdGNwL3JlZDpPSwojICMy
MDMvOSAgIG1wdGNwL2J1cnN0Ok9LCiMgIzIwMyAgICAgbXB0Y3A6T0sKIyBTdW1tYXJ5OiAxLzkg
UEFTU0VELCAwIFNLSVBQRUQsIDAgRkFJTEVECm9rIDEgdGVzdDogYnBmdGVzdF90ZXN0X3Byb2dz
LWNwdXY0X21wdGNwCiMgdGltZT00CkJQRiBUZXN0OiB0ZXN0X3Byb2dzLW5vX2FsdTMyIC10IG1w
dGNwClRBUCB2ZXJzaW9uIDEzCjEuLjEKIyAjMjAzLzEgICBtcHRjcC9iYXNlOk9LCiMgIzIwMy8y
ICAgbXB0Y3AvbXB0Y3BpZnk6T0sKIyAjMjAzLzMgICBtcHRjcC9zdWJmbG93Ok9LCiMgIzIwMy80
ICAgbXB0Y3AvZGVmYXVsdDpPSwojICMyMDMvNSAgIG1wdGNwL2ZpcnN0Ok9LCiMgIzIwMy82ICAg
bXB0Y3AvYmt1cDpPSwojICMyMDMvNyAgIG1wdGNwL3JyOk9LCiMgIzIwMy84ICAgbXB0Y3AvcmVk
Ok9LCiMgIzIwMy85ICAgbXB0Y3AvYnVyc3Q6T0sKIyAjMjAzICAgICBtcHRjcDpPSwojIFN1bW1h
cnk6IDEvOSBQQVNTRUQsIDAgU0tJUFBFRCwgMCBGQUlMRUQKb2sgMSB0ZXN0OiBicGZ0ZXN0X3Rl
c3RfcHJvZ3Mtbm9fYWx1MzJfbXB0Y3AKIyB0aW1lPTQKCgoJPT09IEVSUk9SIGFmdGVyIDI4IGF0
dGVtcHRzIChTYXQsIDE0IEp1biAyMDI1IDEyOjMxOjQ2ICswMDAwKSA9PT0KCg==


--=-ozoXqAR4n9xZB/uiLXfq--
