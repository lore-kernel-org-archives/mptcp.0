Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17A3CB55D
	for <mptcp@lists.linux.dev>; Sat,  5 Sep 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596794; cv=none; b=G6zhpQxQu52/rEJiGNI/LY6M8u4dAL28pukdh9ULDgsAAWh8NHyUy71UHNChxT3xdTCA34SWq2euA4nw2docskaG1Ax4K0vCo8eks2gO7SZ6580IzQbK+hvcXMkqy3UNy0iUIuPE2tSuxwkAbezKOP/0vdDyuVGtqPF+VbztwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596794; c=relaxed/simple;
	bh=Li9xJ/9qsBLTX+27vr6d1kqRZTMBP6AVehDbn8IB7T4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0oonb+xQFXWCXBBI0B5RMO2INK/3GJQK8Weq9I6gaJ2MtxpyfIrp5hj7wcBmasoXOTeLbwzZCRo8FVOwwaM1YggQrGWa6WCfakVloFUGZCXYcZ0iSvuI1zx3YoEOAH5FRqdjXEwO0Xe1vPCDNjv2HQldud5Sw1ii19ayhv4wzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjDoPW5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjDoPW5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3DB1F00A3D;
	Sat,  5 Sep 2026 08:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788596792;
	bh=KniLwPzhRcovhq/ms++dvV72oGJB4zTr6PstJqW/mAw=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=XjDoPW5Xf8GRptFgFxwfbgpREJEY9GBA2XQdJXWK4vUbGOPjOjq4WjNW6rasOvnLg
	 DctvVyh1uGD4JPvnV02W9emTA9xjjrYZS0pN2x/AGRnEQafw8MXMbf4z6fGHOguN0f
	 mqqoH8sIqflpVlO8oilEXyg2sanvwx2+AbyLmeVoNSTPVvV6zQrI4Vbvf1TxklbYNi
	 SsdC6lak03AioAuWReejEbCh9P0y/cqeBz7ufwnuQ/fuUvzEvAR9nmA+Iuomn24EsR
	 Ejj6FO4/LMtap+/MV3IKdokdFrBSAbO1jSrkYvHvWesft6vGh9Yd8Xx2ddBUK92Aaq
	 1Z+KFKjrftLeQ==
Message-ID: <24e7da3ea0b33d5dca970449cf615a4c95ecceb8.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: print stats before
 socket closure
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Sat, 05 Sep 2026 16:26:29 +0800
In-Reply-To: <20260815-sft-mptcp-stats-b4-close-v3-1-ccd9af14cf73@kernel.org>
References: <20260815-sft-mptcp-stats-b4-close-v3-1-ccd9af14cf73@kernel.org>
Content-Type: multipart/mixed; boundary="=-W92beQvJqRl20P3SBO5L"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

--=-W92beQvJqRl20P3SBO5L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2026-08-15 at 00:28 +0200, Matthieu Baerts (NGI0) wrote:
> In case of poll timeout, it might be too late to print the stats
> after
> the socket closure.
> 
> Now, in case of poll timeout, 'ss' and 'nstat' are invoked from
> mptcp_connect to print the stats before exiting. This should help
> debugging poll timeout issues.
> 
> Note: for this "workaround", system() is used for debugging purposes

This print_err_stats() implementation is basically the same as
mptcp_lib_pr_err_stats() in the shell, right?

I think it's better to use mptcp_lib_pr_err_stats() in the shell to
print the information. In mptcp_connect.c, when a poll timeout occurs,
we send a signal to the shell and don't close the socket immediately -
we wait for the shell to finish printing the information before closing
it. What do you think of this approach? There's a reference
implementation in the attachment, but I haven't tested it.

Thanks,
-Geliang

> only. The returned result can then be safely ignored, hence the
> (void)!
> to avoid unused-result warnings.
> 
> Also, 'nstat *Tcp*' will print '#kernel' at the top, but that's OK,
> and
> it seems better to avoid using a pipe here.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v3:
> - use double quotes instead of single ones (Sashiko)
> - Link to v2:
> https://patch.msgid.link/20260814-sft-mptcp-stats-b4-close-v2-1-b7a8ab3ddae8@kernel.org
> 
> Changes in v2:
> - use 'ip netns identify' to avoid a warning from AI reviews
> - use 'nstat -s *Tcp*' instead of using grep
> - add a note about (void)!
> - Link to v1:
> https://patch.msgid.link/20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 15
> +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index ea4cb6c1bd5e..d6c2237bdba0 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -210,6 +210,19 @@ static void xgetaddrinfo(const char *node, const
> char *service,
>  	}
>  }
>  
> +static void print_err_stats(void)
> +{
> +	char cmd[128];
> +
> +	snprintf(cmd, sizeof(cmd), "ss -Menitam -o '%cport = :%s'
> >&2",
> +		 listen_mode ? 's' : 'd', cfg_port);
> +
> +	fprintf(stderr, "socket stats before socket closure:\n");
> +	(void)!system(cmd);
> +	(void)!system("NSTAT_HISTORY=\"/tmp/$(ip netns
> identify).nstat\" "
> +		      "nstat -s '*Tcp*' >&2");
> +}
> +
>  static void set_rcvbuf(int fd, unsigned int size)
>  {
>  	int err;
> @@ -656,6 +669,7 @@ static int copyfd_io_poll(int infd, int peerfd,
> int outfd,
>  			fprintf(stderr, "%s: poll timed out (events:
> "
>  				"POLLIN %u, POLLOUT %u)\n",
> __func__,
>  				fds.events & POLLIN, fds.events &
> POLLOUT);
> +			print_err_stats();
>  			return 2;
>  		}
>  
> @@ -1194,6 +1208,7 @@ int main_loop_s(int listensock)
>  		return 1;
>  	case 0:
>  		fprintf(stderr, "%s: timed out\n", __func__);
> +		print_err_stats();
>  		close(listensock);
>  		return 2;
>  	}
> 
> ---
> base-commit: d536472a82d18356d323227213acb5603bb9050c
> change-id: 20260814-sft-mptcp-stats-b4-close-20964ff6a6ba
> 
> Best regards,
> --  
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 

--=-W92beQvJqRl20P3SBO5L
Content-Disposition: attachment;
	filename*0=0001-Squash-to-selftests-mptcp-print-stats-before-socket-.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-Squash-to-selftests-mptcp-print-stats-before-socket-.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyNzkxZWIwYzg2ZWZjODk5MGJjYzc5YzZhZjA4ZTJlNDlkZDYyMGNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8Mjc5MWViMGM4NmVmYzg5OTBiY2M3OWM2YWYwOGUy
ZTQ5ZGQ2MjBjZC4xNzg4NTk2NDAwLmdpdC50YW5nZ2VsaWFuZ0BreWxpbm9zLmNuPgpGcm9tOiBH
ZWxpYW5nIFRhbmcgPHRhbmdnZWxpYW5nQGt5bGlub3MuY24+CkRhdGU6IFNhdCwgNSBTZXAgMjAy
NiAxNjoxMjo0NiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFNxdWFzaCB0byAic2VsZnRlc3RzOiBt
cHRjcDogcHJpbnQgc3RhdHMgYmVmb3JlIHNvY2tldAogY2xvc3VyZSIKClNpZ25lZC1vZmYtYnk6
IEdlbGlhbmcgVGFuZyA8dGFuZ2dlbGlhbmdAa3lsaW5vcy5jbj4KLS0tCiAuLi4vc2VsZnRlc3Rz
L25ldC9tcHRjcC9tcHRjcF9jb25uZWN0LmMgICAgICAgfCAzNyArKysrKysrKysrKysrLS0tLS0t
CiAuLi4vc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9jb25uZWN0LnNoICAgICAgfCAxNiArKysr
KysrLQogMiBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3BfY29u
bmVjdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2Nvbm5lY3Qu
YwppbmRleCA4Yzc4ODk3N2U1OTQuLjMyMTdkMzIwNjQ4ZSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2Nvbm5lY3QuYworKysgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3BfY29ubmVjdC5jCkBAIC00Nyw2ICs0Nyw3IEBA
IGV4dGVybiBpbnQgb3B0aW5kOwogc3RhdGljIGludCAgcG9sbF90aW1lb3V0ID0gMTAgKiAxMDAw
Owogc3RhdGljIGJvb2wgbGlzdGVuX21vZGU7CiBzdGF0aWMgYm9vbCBxdWl0Oworc3RhdGljIHBp
ZF90IHNoZWxsX3BpZDsKIAogZW51bSBjZmdfbW9kZSB7CiAJQ0ZHX01PREVfUE9MTCwKQEAgLTIx
MCwxNyArMjExLDI4IEBAIHN0YXRpYyB2b2lkIHhnZXRhZGRyaW5mbyhjb25zdCBjaGFyICpub2Rl
LCBjb25zdCBjaGFyICpzZXJ2aWNlLAogCX0KIH0KIAotc3RhdGljIHZvaWQgcHJpbnRfZXJyX3N0
YXRzKHZvaWQpCitzdGF0aWMgdm9sYXRpbGUgaW50IHNoZWxsX3dva2VuOworCitzdGF0aWMgdm9p
ZCB3YWtlX2hhbmRsZXIoaW50IHNpZykKIHsKLQljaGFyIGNtZFsxMjhdOworCXNoZWxsX3dva2Vu
ID0gMTsKK30KIAotCXNucHJpbnRmKGNtZCwgc2l6ZW9mKGNtZCksICJzcyAtTWVuaXRhbSAtbyAn
JWNwb3J0ID0gOiVzJyA+JjIiLAotCQkgbGlzdGVuX21vZGUgPyAncycgOiAnZCcsIGNmZ19wb3J0
KTsKKy8qIE5vdGlmeSB0aGUgc2hlbGwgc2NyaXB0IHRoYXQgYSBwb2xsIHRpbWVvdXQgb2NjdXJy
ZWQsIHRoZW4gcGF1c2Ugd2l0aCB0aGUKKyAqIHNvY2tldCBzdGlsbCBvcGVuLiBUaGUgc2hlbGwg
Y29sbGVjdHMgc29ja2V0IHN0YXRzIHZpYSBzcy9uc3RhdCB3aGlsZSB0aGUKKyAqIGZkIGlzIHN0
aWxsIGFsaXZlLCB0aGVuIHNlbmRzIHVzIFNJR1VTUjEgdG8gd2FrZSB1cyB1cCBzbyB3ZSBjYW4g
ZXhpdC4KKyAqLworc3RhdGljIHZvaWQgbm90aWZ5X3NoZWxsKHZvaWQpCit7CisJaWYgKCFzaGVs
bF9waWQpCisJCXJldHVybjsKKworCXNoZWxsX3dva2VuID0gMDsKKwlzaWduYWwoU0lHVVNSMSwg
d2FrZV9oYW5kbGVyKTsKKwlraWxsKHNoZWxsX3BpZCwgU0lHVVNSMSk7CiAKLQlmcHJpbnRmKHN0
ZGVyciwgInNvY2tldCBzdGF0cyBiZWZvcmUgc29ja2V0IGNsb3N1cmU6XG4iKTsKLQkodm9pZCkh
c3lzdGVtKGNtZCk7Ci0JKHZvaWQpIXN5c3RlbSgiTlNUQVRfSElTVE9SWT1cIi90bXAvJChpcCBu
ZXRucyBpZGVudGlmeSkubnN0YXRcIiAiCi0JCSAgICAgICJuc3RhdCAtcyAnKlRjcConID4mMiIp
OworCXdoaWxlICghc2hlbGxfd29rZW4pCisJCXBhdXNlKCk7CiB9CiAKIHN0YXRpYyB2b2lkIHNl
dF9yY3ZidWYoaW50IGZkLCB1bnNpZ25lZCBpbnQgc2l6ZSkKQEAgLTY3MSw3ICs2ODMsNyBAQCBz
dGF0aWMgaW50IGNvcHlmZF9pb19wb2xsKGludCBpbmZkLCBpbnQgcGVlcmZkLCBpbnQgb3V0ZmQs
CiAJCQlmcHJpbnRmKHN0ZGVyciwgIiVzOiBwb2xsIHRpbWVkIG91dCAoZXZlbnRzOiAiCiAJCQkJ
IlBPTExJTiAldSwgUE9MTE9VVCAldSlcbiIsIF9fZnVuY19fLAogCQkJCWZkcy5ldmVudHMgJiBQ
T0xMSU4sIGZkcy5ldmVudHMgJiBQT0xMT1VUKTsKLQkJCXByaW50X2Vycl9zdGF0cygpOworCQkJ
bm90aWZ5X3NoZWxsKCk7CiAJCQlyZXR1cm4gMjsKIAkJfQogCkBAIC0xMjEwLDcgKzEyMjIsNyBA
QCBpbnQgbWFpbl9sb29wX3MoaW50IGxpc3RlbnNvY2spCiAJCXJldHVybiAxOwogCWNhc2UgMDoK
IAkJZnByaW50ZihzdGRlcnIsICIlczogdGltZWQgb3V0XG4iLCBfX2Z1bmNfXyk7Ci0JCXByaW50
X2Vycl9zdGF0cygpOworCQlub3RpZnlfc2hlbGwoKTsKIAkJY2xvc2UobGlzdGVuc29jayk7CiAJ
CXJldHVybiAyOwogCX0KQEAgLTE1MzEsNyArMTU0Myw3IEBAIHN0YXRpYyB2b2lkIHBhcnNlX29w
dHMoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewogCWludCBjOwogCi0Jd2hpbGUgKChjID0gZ2V0
b3B0KGFyZ2MsIGFyZ3YsICI2YzpmOmhpOkk6amxtOk06bzpwOlA6cjpSOnM6Uzp0OlQ6dzoiKSkg
IT0gLTEpIHsKKwl3aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwgIjZjOmY6aGk6STpqbG06
TTpvOnA6UDpyOlI6czpTOnQ6VDp3Olc6IikpICE9IC0xKSB7CiAJCXN3aXRjaCAoYykgewogCQlj
YXNlICdmJzoKIAkJCWNmZ190cnVuY2F0ZSA9IGF0b2kob3B0YXJnKTsKQEAgLTE1OTcsNiArMTYw
OSw5IEBAIHN0YXRpYyB2b2lkIHBhcnNlX29wdHMoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCQlj
YXNlICd3JzoKIAkJCWNmZ193YWl0ID0gYXRvaShvcHRhcmcpKjEwMDAwMDA7CiAJCQlicmVhazsK
KwkJY2FzZSAnVyc6CisJCQlzaGVsbF9waWQgPSBhdG9pKG9wdGFyZyk7CisJCQlicmVhazsKIAkJ
Y2FzZSAnTSc6CiAJCQljZmdfbWFyayA9IHN0cnRvbChvcHRhcmcsIE5VTEwsIDApOwogCQkJYnJl
YWs7CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3Bf
Y29ubmVjdC5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9jb25u
ZWN0LnNoCmluZGV4IDdhMmE4NTFmYTBhZC4uNjFkNzAzMWFjZDQxIDEwMDc1NQotLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3BfY29ubmVjdC5zaAorKysgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3BfY29ubmVjdC5zaApAQCAtMzk0LDcg
KzM5NCw3IEBAIGRvX3RyYW5zZmVyKCkKIAlmaQogCiAJaXAgbmV0bnMgZXhlYyAke2xpc3RlbmVy
X25zfSBcCi0JCS4vbXB0Y3BfY29ubmVjdCAtdCAke3RpbWVvdXRfcG9sbH0gLWwgLXAgJHBvcnQg
LXMgJHtzcnZfcHJvdG99IFwKKwkJLi9tcHRjcF9jb25uZWN0IC10ICR7dGltZW91dF9wb2xsfSAt
VyAkJCAtbCAtcCAkcG9ydCAtcyAke3Nydl9wcm90b30gXAogCQkJJGV4dHJhX2FyZ3MgJGxvY2Fs
X2FkZHIgPCAiJHNpbiIgPiAiJHNvdXQiICYKIAlsb2NhbCBzcGlkPSQhCiAKQEAgLTQwMyw3ICs0
MDMsNyBAQCBkb190cmFuc2ZlcigpCiAJbG9jYWwgc3RhcnQKIAlzdGFydD0kKGRhdGUgKyVzJU4p
CiAJaXAgbmV0bnMgZXhlYyAke2Nvbm5lY3Rvcl9uc30gXAotCQkuL21wdGNwX2Nvbm5lY3QgLXQg
JHt0aW1lb3V0X3BvbGx9IC1wICRwb3J0IC1zICR7Y2xfcHJvdG99IFwKKwkJLi9tcHRjcF9jb25u
ZWN0IC10ICR7dGltZW91dF9wb2xsfSAtVyAkJCAtcCAkcG9ydCAtcyAke2NsX3Byb3RvfSBcCiAJ
CQkkZXh0cmFfYXJncyAkY29ubmVjdF9hZGRyIDwgIiRjaW4iID4gIiRjb3V0IiAmCiAJbG9jYWwg
Y3BpZD0kIQogCkBAIC00MTEsMTEgKzQxMSwyMyBAQCBkb190cmFuc2ZlcigpCiAJCSIke2Nvbm5l
Y3Rvcl9uc30iICIke3BvcnR9IiAiJHtjcGlkfSIgIiR7c3BpZH0iICYKIAlsb2NhbCB0aW1lb3V0
X3BpZD0kIQogCisJbG9jYWwgdGltZWRfb3V0PTAKKwl0cmFwICd0aW1lZF9vdXQ9MScgVVNSMQor
CiAJd2FpdCAkY3BpZAogCWxvY2FsIHJldGM9JD8KIAl3YWl0ICRzcGlkCiAJbG9jYWwgcmV0cz0k
PwogCisJaWYgWyAke3RpbWVkX291dH0gLWVxIDEgXTsgdGhlbgorCQkjIG1wdGNwX2Nvbm5lY3Qg
cGF1c2VkIG9uIHBvbGwgdGltZW91dCwgc29ja2V0IHN0aWxsIG9wZW4gLQorCQkjIGNvbGxlY3Qg
c3RhdHMgbm93IHdoaWxlIHRoZSBmZCBpcyBhbGl2ZSwgdGhlbiB3YWtlIHRoZW0gdXAKKwkJbXB0
Y3BfbGliX3ByX2Vycl9zdGF0cyAiJHtsaXN0ZW5lcl9uc30iICIke2Nvbm5lY3Rvcl9uc30iICIk
e3BvcnR9IgorCQlraWxsIC1VU1IxICRjcGlkICRzcGlkIDI+L2Rldi9udWxsCisJCXdhaXQgJGNw
aWQ7IHJldGM9JD8KKwkJd2FpdCAkc3BpZDsgcmV0cz0kPworCWZpCisKIAlpZiBraWxsIC0wICR0
aW1lb3V0X3BpZDsgdGhlbgogCQkjIEZpbmlzaGVkIGJlZm9yZSB0aGUgdGltZW91dDoga2lsbCB0
aGUgYmFja2dyb3VuZCBqb2IKIAkJbXB0Y3BfbGliX2tpbGxfZ3JvdXBfd2FpdCAkdGltZW91dF9w
aWQKLS0gCjIuNTMuMAoK


--=-W92beQvJqRl20P3SBO5L--
