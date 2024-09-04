Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65763D;
	Wed,  4 Sep 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460627; cv=none; b=DnRJrKJJVPl/dd394CiLwb9hCPYH11G6kMjPozq5Se4yuS9rYvmvxA1yinjS511mDc2Ga3RsiXTyF1GMa2LrXzLAkGm9/VkmNTH/gPb73+VpnS3T8p+ZM0WmK9sWM+5Y5TRFi27kavMVhGqJGT0pjDvjzBlCJLrOydl5U9XYoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460627; c=relaxed/simple;
	bh=DuzjwOCv7T/oTL8VaVZ6ohs2gb8IDBnXfeGZFwmCHQc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Qtq68tnkTmdESNlg3XJeVKaNXx2D1eUGaXGF/asl/CqA73SXNMf2xs+BhxaK2obIVobVRn9Y3UZhCIxLEXqG5vl2Rs6cIoYfW6mWZaJO4+rcdSPk4R9CkkIxZa9EZqkrHe+OsOBYBWo2wD2e2V3TjV3F7VdJB4pCmETPJYGr/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tCeewa93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tCeewa93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A844C4CEC9;
	Wed,  4 Sep 2024 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460626;
	bh=DuzjwOCv7T/oTL8VaVZ6ohs2gb8IDBnXfeGZFwmCHQc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=tCeewa936uzfNobr8VYgqLusayo+5KhpWu+NRjVj0zpXShCH/4XL8kIIU21rRyDqy
	 7GPfLadCSRpNqJuUABHAwZWgqgI9mB3srg5SNILFZ5YoJd0iVo4dshMZoWZVBNKOI5
	 /fIaOpdiL5sq722M9KmRYTYfdiATWqK24H8E/lsE=
Subject: Patch "selftests: mptcp: join: no extra msg if no counter" has been added to the 6.1-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:36:56 +0200
In-Reply-To: <20240904111233.4094425-2-matttbe@kernel.org>
Message-ID: <2024090456-vaporizer-relatable-59e8@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    selftests: mptcp: join: no extra msg if no counter

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-no-extra-msg-if-no-counter.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73020-greg=kroah.com@vger.kernel.org Wed Sep  4 13:14:55 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 13:12:34 +0200
Subject: selftests: mptcp: join: no extra msg if no counter
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240904111233.4094425-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 76a2d8394cc183df872adf04bf636eaf42746449 upstream.

The checksum and fail counters might not be available. Then no need to
display an extra message with missing info.

While at it, fix the indentation around, which is wrong since the same
commit.

Fixes: 47867f0a7e83 ("selftests: mptcp: join: skip check if MIB counter not supported")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh, because the context is different, but the
  exact same fix can still be applied on the modified lines: adding
  '[ -n "$count" ]', and fixing the indentation. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1252,13 +1252,13 @@ chk_csum_nr()
 
 	printf "%-${nr_blank}s %s" " " "sum"
 	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns1" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		fail_test
 		dump_stats=1
@@ -1267,13 +1267,13 @@ chk_csum_nr()
 	fi
 	echo -n " - csum  "
 	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns2" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
 		dump_stats=1
@@ -1315,13 +1315,13 @@ chk_fail_nr()
 
 	printf "%-${nr_blank}s %s" " " "ftx"
 	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
-	if [ "$count" != "$fail_tx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
 		dump_stats=1
@@ -1331,13 +1331,13 @@ chk_fail_nr()
 
 	echo -n " - failrx"
 	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
-	if [ "$count" != "$fail_rx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
 		dump_stats=1


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-fix-rm_addr-id-for-the-initial-subflow.patch
queue-6.1/selftests-mptcp-join-validate-fullmesh-endp-on-1st-sf.patch
queue-6.1/mptcp-pm-fix-id-0-endp-usage-after-multiple-re-creations.patch
queue-6.1/mptcp-make-pm_remove_addrs_and_subflows-static.patch
queue-6.1/mptcp-pm-avoid-possible-uaf-when-selecting-endp.patch
queue-6.1/mptcp-pm-reuse-id-0-after-delete-and-re-add.patch
queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-id.patch
queue-6.1/selftests-mptcp-join-test-for-flush-re-add-endpoints.patch
queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
queue-6.1/mptcp-avoid-duplicated-sub_closed-events.patch
queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-readd.patch
queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-closed-subflow.patch
queue-6.1/selftests-mptcp-join-check-re-re-adding-id-0-endp.patch
queue-6.1/mptcp-pm-fullmesh-select-the-right-id-later.patch
queue-6.1/selftests-mptcp-join-no-extra-msg-if-no-counter.patch
queue-6.1/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
queue-6.1/selftests-mptcp-join-check-removing-id-0-endpoint.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add_addr.patch
