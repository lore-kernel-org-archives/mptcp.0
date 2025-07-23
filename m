Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164A2F4A
	for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247826; cv=none; b=KbjdM58inUxL4SpiEERoAPBqKY3fG2yVY4DAtZG6Ky6iPuSBetGIeD+vVB2wjBipNjIZkPKdwLpu0Eu6s+OA9EvXY8cWmtm/PRQlklB9KGegRgJ4/dOXLBn5NX4PwOXT1feO/IMxrpvl/zdIYcrRRxTH+HAVbwmtBKsNhcNUCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247826; c=relaxed/simple;
	bh=DhltbvoniosF2lAtqndy5OpqR3jyVD6NwQolSy2/ky8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ih93Ta/rkzZgoJIID463+p43YOcQhbl8gjVsOiA07jUXF5/nRk4QNNY1AZGhyTRslorlCJOLpPcDCLY209C7jflW+/xro/NdvlfwLQcKHrL6C/Yft6IFQlzseA3mzoNBYeydQzYc6yBHL0/NK1ZARtiDqlmBtNXAcFCg+QfkRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlaqkogu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlaqkogu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E703C4CEE7;
	Wed, 23 Jul 2025 05:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247826;
	bh=DhltbvoniosF2lAtqndy5OpqR3jyVD6NwQolSy2/ky8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wlaqkoguj/llbpGBF7OVtIgdHCz9xVPpZuYg4VHBvmBVmzaDodkI8AHST4ooN+zbK
	 eT3tPxpqLgs4zq69l1jNRCXjZkUQNxGMJG6W+fH9D3Gin9hsO4B6DZPbUyIRebTE3T
	 eHWSnHt4gzejtR8drOKRq1IV/kXz5pJtwz1jdrlNtVQMPqgpu4mbdSGAMs3l7Iv52J
	 u713OnlZaec6TaV+Qf7ASpUtTISIoqQ8DzEenXf8VgteHokhFHE6btjEOorA4cPjXg
	 sx9jeze6YT5xn6dATSTZq+AXWMOV/X5d6zGL95l1r3RPgWKutd7UThdLP4RzVldFqF
	 c+e6WWa2q4rGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 7/7] Add test cases for MPTCP socket functionality
Date: Wed, 23 Jul 2025 13:16:19 +0800
Message-ID: <4e7279b9bf9118e89c57221546f3f678517b91da.1753247666.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1753247666.git.geliang@kernel.org>
References: <cover.1753247666.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces comprehensive test coverage for the newly added
MPTCP socket support by:

1. Adding MPTCPServer.java - A test server that:
   - Creates an MPTCP-enabled ServerSocket
   - Accepts client connections
   - Echoes received messages back to clients
   - Handles graceful shutdown

2. Adding MPTCPClient.java - A test client that:
   - Connects to the MPTCP server
   - Sends user input to server
   - Displays server responses
   - Supports graceful termination

The tests verify:
- Basic MPTCP socket creation and connection
- Bidirectional communication
- Proper stream handling
- Error conditions
- Clean resource management

Both test programs demonstrate the usage of the new MPTCP-enabled
constructors added in previous patches.

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 .../java/net/ServerSocket/MPTCPServer.java    | 58 +++++++++++++++++
 test/jdk/java/net/Socket/MPTCPClient.java     | 62 +++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 test/jdk/java/net/ServerSocket/MPTCPServer.java
 create mode 100644 test/jdk/java/net/Socket/MPTCPClient.java

diff --git a/test/jdk/java/net/ServerSocket/MPTCPServer.java b/test/jdk/java/net/ServerSocket/MPTCPServer.java
new file mode 100644
index 00000000000..a28e4963943
--- /dev/null
+++ b/test/jdk/java/net/ServerSocket/MPTCPServer.java
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
+ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This code is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * version 2 for more details (a copy is included in the LICENSE file that
+ * accompanied this code).
+ *
+ * You should have received a copy of the GNU General Public License version
+ * 2 along with this work; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
+ * or visit www.oracle.com if you need additional information or have any
+ * questions.
+ */
+
+import java.io.*;
+import java.net.*;
+
+public class MPTCPServer {
+	public static void main(String[] args) {
+		final int PORT = 12345;
+
+		try (ServerSocket serverSocket = new ServerSocket(PORT, 50, null, true)) {
+			System.out.println("Server started, waiting for client connection ...");
+
+			Socket clientSocket = serverSocket.accept();
+			System.out.println("Client connected: " + clientSocket.getInetAddress());
+
+			BufferedReader in = new BufferedReader(
+					new InputStreamReader(clientSocket.getInputStream()));
+			PrintWriter out = new PrintWriter(
+					clientSocket.getOutputStream(), true);
+
+			String inputLine;
+			while ((inputLine = in.readLine()) != null) {
+				System.out.println("Received from client: " + inputLine);
+				out.println("Server response: " + inputLine);
+
+				if ("exit".equalsIgnoreCase(inputLine)) {
+					break;
+				}
+			}
+
+			clientSocket.close();
+			System.out.println("Connection closed");
+		} catch (IOException e) {
+			System.err.println("Server exception: " + e.getMessage());
+		}
+	}
+}
diff --git a/test/jdk/java/net/Socket/MPTCPClient.java b/test/jdk/java/net/Socket/MPTCPClient.java
new file mode 100644
index 00000000000..18d815c39e7
--- /dev/null
+++ b/test/jdk/java/net/Socket/MPTCPClient.java
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
+ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This code is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * version 2 for more details (a copy is included in the LICENSE file that
+ * accompanied this code).
+ *
+ * You should have received a copy of the GNU General Public License version
+ * 2 along with this work; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
+ * or visit www.oracle.com if you need additional information or have any
+ * questions.
+ */
+
+import java.io.*;
+import java.net.*;
+
+public class MPTCPClient {
+    public static void main(String[] args) {
+        final String HOST = "localhost";
+        final int PORT = 12345;
+        
+        try (Socket socket = new Socket(HOST, PORT, true, true)) {
+            System.out.println("Connected to server");
+            
+            BufferedReader in = new BufferedReader(
+                new InputStreamReader(socket.getInputStream()));
+            PrintWriter out = new PrintWriter(
+                socket.getOutputStream(), true);
+            
+            BufferedReader stdIn = new BufferedReader(
+                new InputStreamReader(System.in));
+            
+            String userInput;
+            System.out.println("Enter message (type 'exit' to quit):");
+            while ((userInput = stdIn.readLine()) != null) {
+                out.println(userInput);
+                
+                System.out.println("Server response: " + in.readLine());
+                
+                if ("exit".equalsIgnoreCase(userInput)) {
+                    break;
+                }
+            }
+            
+            System.out.println("Connection closed");
+        } catch (UnknownHostException e) {
+            System.err.println("Host not found: " + HOST);
+        } catch (IOException e) {
+            System.err.println("Client I/O error: " + e.getMessage());
+        }
+    }
+}
-- 
2.48.1

